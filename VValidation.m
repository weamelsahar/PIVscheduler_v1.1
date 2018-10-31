function [Nko,Ntot]=VValidation(varargin)
% [NKO,NTOT] = VVALIDATION(PLTFILE,SNTR,P)
% INPUT : PLTFILE - THE NAME (INCLUDING THE DIRECTORY) OF THE PLT FILE TO
%   READ AND CHECK.
%         SNTR    - THRESHOLD ON SIGNAL-TO-NOISE RATIO (DEFAULT = 1.3)
%         P       - FLAG TO PLOT THE DATA OR NOT. YES=1, NO=0 (DEFAULT)
% OUTPUT : NKO - THE NUMBER OF NON-VALID VECTORS (OUTLIERS)
%          NTOT- THE TOTAL NUMBER OF VECTORS
%

pltfile=varargin{1};
if nargin==2
    if varargin{2}==1 || varargin{2}==0; SNTR=1.3; P=varargin{2};end;
    if varargin{2}>1; SNTR=varargin{2}; P=0; end;
elseif nargin==1
    SNTR=1.3; 
    P=0;
else
    SNTR=varargin{2};
    P=varargin{3};
end
    
    %Read PLT file
    [xv,yv,u,v,sn,I,J,filefound] = read_file(pltfile);
    if filefound==1
        %Total number of vectors
        Ntot = I*J;
        %Reshape vectors
        xv  = reshape(xv(:),I,J);
        yv  = reshape(yv(:),I,J);
        u  = reshape(u(:),I,J);
        v  = reshape(v(:),I,J);
        sn = reshape(sn(:),I,J);
        %initialise
        F  = ones(I,J);
        %run over elements
        for r=1:I
            %indices
            r_in = max(r-2,1);
            r_en = min(r+2,I);
            %run over column
            for c=1:J
                if sn(r,c)<SNTR %vector does not satisfy SN threshold
                    F(r,c)=0;
                else %vector's SN is ok --> check median normalised median threshold
                    %indices
                    c_in = max(c-2,1);
                    c_en = min(c+2,J);
                    %temporary matrices
                    bf_u = u(r_in:r_en,c_in:c_en); bf_u=bf_u(:);
                    bf_v = v(r_in:r_en,c_in:c_en); bf_v=bf_v(:);
                    umed = median(bf_u);
                    vmed = median(bf_v);
                    fu   = median(abs(bf_u-umed));
                    fv   = median(abs(bf_v-vmed));
                    nu   = abs(u(r,c)-umed)./(fu+0.1);
                    nv   = abs(v(r,c)-vmed)./(fv+0.1);
                    norm = sqrt(nu.^2+nv.^2);
                    if norm>2; F(r,c)=0; end;
                end
            end
        end
        %number of non-valid vectors
        Nko = sum(1-F(:));
        %plot
        if P==1
            figure(1);
            clf;
            id = (F==1);
            scale = 8./max(sqrt( u(id).*u(id) + v(id).*v(id) ));
            hq = quiver(xv(id),yv(id),scale.*u(id),scale.*v(id),0); set(hq,'color','k');
            hold on;
            id = (F==0);
            hq = quiver(xv(id),yv(id),scale.*u(id),scale.*v(id),0); set(hq,'color','r');
            set(gca,'fontsize',28);
            set(gca,'linewidth',2);
            box on;
            xlabel('X','fontsize',28);
            ylabel('Y','fontsize',28);
        end
    else
        disp('File not found');
        Nko = 0;
        Ntot= 0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,y,u,v,sn,I,J,filefound] = read_file(file)
    if length(dir([file]))>0
    % file was found
        % Read PLT-file
		fid=fopen(file,'r');
            line = fgetl(fid);
            line = fgetl(fid);
            line = fgetl(fid);
            Ifind = findstr(line,'I');
            cfind = findstr(line,',');
            Jfind = findstr(line,'J');
            eval([line(Ifind:cfind(2)-1) ';']);
            eval([line(Jfind:end) ';']);
            a     = fgetl(fid);
            nb_col= length(str2num(a));
        fclose(fid);
         
        fid=fopen(file,'r');
            line = fgetl(fid);
            line = fgetl(fid);
            line = fgetl(fid);
            Ifind = findstr(line,'I');
            cfind = findstr(line,',');
            Jfind = findstr(line,'J');
            eval([line(Ifind:cfind(2)-1) ';']);
            eval([line(Jfind:end) ';']);
        	col   = nb_col;
    		lin   = I*J;
    		[A,~]=fscanf(fid,'%g',[col,lin]);
		fclose(fid);
		
        % Put data in vectors
		x   =   A(1,:); x=x';
		y   =   A(2,:); y=y';
		u   =   A(3,:); u=u';
		v   =   A(4,:); v=v';
        sn  =   A(5,:); sn=sn';
        filefound=1;
    else
        x   = 0;
        y   = x;
        u   = x;
        v   = x;
        sn  = x;
        I   = 0;
        J   = 0;
        filefound=0;
    end;            
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

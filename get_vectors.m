function [Vectors]=get_vectors(Main_folder)

[Vectors]=dir([Main_folder(1:end-length('\Renamed')),'\Vectors\*.plt']);

end
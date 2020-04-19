warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
%% Exercise 1
sigma = 0.05;
Bus = readtable("lf_EM_Bus.dat");
Line = readtable("lf_EM_Line.dat");
Transfo = readtable("lf_EM_Transfo.dat");
Gen = readtable("lf_EM_Gen.dat");
Turlim = readtable("lf_EM_Turlim.dat");
Slack = readtable("lf_EM_Slack.dat");
Pc = sum(Bus.PLOAD); % [MW] - Total load
PN = Gen.P; %[MW] - Generators nominal production
D = 0.01; % [/Hz] - Load sensitivity coefficieny
fN = 50; % [Hz] - Initial frequency

%% First scenario: Triping line L311-310

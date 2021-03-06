clear all
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

%% Line max current
j = sqrt(-1);
Snom = Line.SNOM;
R = Line.R;
X = Line.X;
wC2 = Line.WC_2;
Y2 = 1./(R+j*X);
Y = zeros(2,2,length(R));
for i=1:length(R)
    Y(:,:,i) = [j*wC2(i)*1e6+Y2(i) -Y2(i);-Y2(i) j*wC2(i)*1e6+Y2(i)]; 
end
Vnom = zeros(size(Snom));
for i=1:length(Vnom)
Vnom(i) = Bus.VNOM(Bus.NAME == string(Line.FROM_BUS(i)));
end
%S = sqrt((RI^2)^2 + (XI^2)^2)
I_max = (Snom.*1e6)./(sqrt(3).*Vnom*1e3);
PMAX = 3*I_max.^2./real(Y2)/1e6;
NAME = Line.NAME;
P_adm = table(NAME, PMAX);


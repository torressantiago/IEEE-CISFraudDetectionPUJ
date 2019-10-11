%% Data treatment - Transaction
%% Load Data
TrainDataFile = 'Data/train_transaction.csv';
TrainDataFile = readtable(TrainDataFile);

%% Number treatment
A(:,1:4) = TrainDataFile(:,1:4); A(:,5:7) = TrainDataFile(:,6:2:10);
A(:,8:11) = TrainDataFile(:,12:15); A(:,12:40) = TrainDataFile(:,18:46);
A(:,41:378) = TrainDataFile(:,56:393);

% Headers
AH = ["TransactionID","isFraud","TransactionDT","TransactionAmt","card1","card3","card5","addr1","addr2","dist1","dist2","C1","C2","C3","C4","C5","C6","C7","C8","C9","C10","C11","C12","C13","C14","D1","D2","D3","D4","D5","D6","D7","D8","D9","D10","D11","D12","D13","D14","D15","V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15","V16","V17","V18","V19","V20","V21","V22","V23","V24","V25","V26","V27","V28","V29","V30","V31","V32","V33","V34","V35","V36","V37","V38","V39","V40","V41","V42","V43","V44","V45","V46","V47","V48","V49","V50","V51","V52","V53","V54","V55","V56","V57","V58","V59","V60","V61","V62","V63","V64","V65","V66","V67","V68","V69","V70","V71","V72","V73","V74","V75","V76","V77","V78","V79","V80","V81","V82","V83","V84","V85","V86","V87","V88","V89","V90","V91","V92","V93","V94","V95","V96","V97","V98","V99","V100","V101","V102","V103","V104","V105","V106","V107","V108","V109","V110","V111","V112","V113","V114","V115","V116","V117","V118","V119","V120","V121","V122","V123","V124","V125","V126","V127","V128","V129","V130","V131","V132","V133","V134","V135","V136","V137","V138","V139","V140","V141","V142","V143","V144","V145","V146","V147","V148","V149","V150","V151","V152","V153","V154","V155","V156","V157","V158","V159","V160","V161","V162","V163","V164","V165","V166","V167","V168","V169","V170","V171","V172","V173","V174","V175","V176","V177","V178","V179","V180","V181","V182","V183","V184","V185","V186","V187","V188","V189","V190","V191","V192","V193","V194","V195","V196","V197","V198","V199","V200","V201","V202","V203","V204","V205","V206","V207","V208","V209","V210","V211","V212","V213","V214","V215","V216","V217","V218","V219","V220","V221","V222","V223","V224","V225","V226","V227","V228","V229","V230","V231","V232","V233","V234","V235","V236","V237","V238","V239","V240","V241","V242","V243","V244","V245","V246","V247","V248","V249","V250","V251","V252","V253","V254","V255","V256","V257","V258","V259","V260","V261","V262","V263","V264","V265","V266","V267","V268","V269","V270","V271","V272","V273","V274","V275","V276","V277","V278","V279","V280","V281","V282","V283","V284","V285","V286","V287","V288","V289","V290","V291","V292","V293","V294","V295","V296","V297","V298","V299","V300","V301","V302","V303","V304","V305","V306","V307","V308","V309","V310","V311","V312","V313","V314","V315","V316","V317","V318","V319","V320","V321","V322","V323","V324","V325","V326","V327","V328","V329","V330","V331","V332","V333","V334","V335","V336","V337","V338"];

A = table2array(A);

%% String Treatment
% Data
B(:,1:4) = TrainDataFile(:,5:2:11); B(:,5:6) = TrainDataFile(:,16:17);
B(:,7:15) = TrainDataFile(:,47:55); B(:,16) = TrainDataFile(:,394);

% Headers
BH = ["ProductCD","card2","card4","card6","P_emaildomain","R_emaildomain","M1","M2","M3","M4","M5","M6","M7","M8","M9","V339"];

B = table2cell(B);

idn = cellfun(@isnumeric,B); % identify numeric values.
out = nan(size(B));          % preallocate output matrix.
out(idn) = [B{idn}];         % allocate numeric values.
tmp = B(~idn);               % subset with char vectors.
C = unique(tmp);
V = 1:413;
[idm,idc] = ismember(tmp,C); % lookup table.
assert(all(idm),'Not in C:%s',sprintf(' %s,',C{~idm}))
vec = V(idc);
out(~idn) = vec;

B = out;

B(B == 1) = NaN;

%% Unify and export
TrainData = [A, B];

TrainDataH = [AH, BH];

save TrainData.mat TrainData
save TrainDataH.mat TrainDataH
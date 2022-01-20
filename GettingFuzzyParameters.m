function p=GettingFuzzyParameters(fis)
    p=[];
    nInput=numel(fis.input);
    for i=1:nInput
        nMF=numel(fis.input(i).mf);
        for j=1:nMF
            p=[p fis.input(i).mf(j).params];
        end
    end
    nOutput=numel(fis.output);
    for i=1:nOutput
        nMF=numel(fis.output(i).mf);
        for j=1:nMF
            p=[p fis.output(i).mf(j).params];
        end
    end  
end
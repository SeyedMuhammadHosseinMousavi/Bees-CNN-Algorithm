function fis=FuzzyParameters(fis,p)
    nInput=numel(fis.input);
    for i=1:nInput
        nMF=numel(fis.input(i).mf);
        for j=1:nMF
            k=numel(fis.input(i).mf(j).params);
            fis.input(i).mf(j).params=p(1:k);
            p(1:k)=[];
        end
    end
    nOutput=numel(fis.output);
    for i=1:nOutput
        nMF=numel(fis.output(i).mf);
        for j=1:nMF
            k=numel(fis.output(i).mf(j).params);
            fis.output(i).mf(j).params=p(1:k);
            p(1:k)=[];
        end
    end
end
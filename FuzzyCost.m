function [z, out]=FuzzyCost(x,fis,data)
    MinAbs=1e-5;
    if any(abs(x)<MinAbs)
        S=(abs(x)<MinAbs);
        x(S)=MinAbs.*sign(x(S));
    end
    p0=GettingFuzzyParameters(fis);
    p=x.*p0;  
    fis=FuzzyParameters(fis,p);   
    x=data.TrainInputs;
    t=data.TrainTargets;
    y=evalfis(x,fis);    
    e=t-y;    
    MSE=mean(e(:).^2);
    RMSE=sqrt(MSE);    
    z=RMSE;    
    out.fis=fis;
    out.MSE=MSE;
    out.RMSE=RMSE;
    
end
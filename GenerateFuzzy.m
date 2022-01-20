
function fis=GenerateFuzzy(data,nCluster)
    if ~exist('nCluster','var')
        nCluster='auto';
    end
    x=data.TrainInputs;
    t=data.TrainTargets;
    % Important Params
    fcm_U=2;
    fcm_MaxIter=100;
    fcm_MinImp=1e-5;
    %
    fcm_Display=false;
    fcm_options=[fcm_U fcm_MaxIter fcm_MinImp fcm_Display];
    fis=genfis3(x,t,'sugeno',nCluster,fcm_options);
end
% Do not change the function name. You have to write your code here
% you have to submit this function
function segmentedImage =KMeans(featureImageIn, numberofClusters, clusterCentersIn)

% Get the dimensions of the input feature image
[M, N, noF] = size(featureImageIn);
% some initialization
% if no clusterCentersIn or it is empty, randomize the clusterCentersIn
% and run kmeans several times and keep the best one
if (nargin == 3) && (~isempty(clusterCentersIn))
    NofRadomization = 1;
else
    NofRadomization = 5;    % Should be greater than one
end
segmentedImage = zeros(M, N); %initialize. This will be the output
BestDfit = 1e10;  % Just a big number!
% ----------------------------------- % 
% -You have to write your code here-- %
% ----------------------------------- %
 % randomize if clusterCentersIn was empty
F = reshape(featureImageIn,size(featureImageIn,1)*size(featureImageIn,2),noF);
b = zeros(size(F,1),5);                                        % matrix for storing the clusters for each iterations
a = zeros(1,NofRadomization);                                  %stores the minimum distance for each iterations
K = numberofClusters;
for KMeanNo = 1:NofRadomization                                % run KMeans NofRadomization times
if NofRadomization>1
        clusterCentersIn = rand(numberofClusters, noF);        %randomize initialization
end
CENTRES = clusterCentersIn;
Distlabel   = zeros(size(F,1),K+2);                            % Distances and Labels
 for n = 1:20
 for i = 1:size(F,1)
      for j = 1:K  
        Distlabel(i,j) = norm(F(i,:) - CENTRES(j,:));      
      end
      [Distance, CLUSTER] = min(Distlabel(i,1:K));               % 1:K are Distance from Cluster Centers 1:K 
      Distlabel(i,K+1) = CLUSTER;                                % Cluster Label
      Distlabel(i,K+2) = Distance;                               % Minimum Distance
   end
   for i = 1:K
      A = (Distlabel(:,K+1) == i);                               % Cluster K Points
      CENTRES(i,:) = mean(F(A,:));                               % New Cluster Centers      
   end
 end
b(:,KMeanNo) = Distlabel(:,K+1);                                 %Storing the value of clusters 
a(KMeanNo)=sum(Distlabel(:,K+2));                                %Storing the value of minimum distance
end
minimum = min(a);                                                %finding the best minima
 for i=1:NofRadomization
     if(a(i) == minimum)
         segmentedImage = reshape(b(:,i),M,N);                   %Best segmented image
     end
 end
 segmentedImage=segmentedImage/max(segmentedImage(:));           %Normalising
end





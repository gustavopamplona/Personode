function [peak_value,vec,x,y,z,MNIx,MNIy,MNIz,atlasInfo,exc,mask]=findPeaks(tmp_names,compImage,class,subj,vec,exc,sep,workPath)

D = dir([workPath filesep 'Clusters']);
atlasInfo=spm_vol([workPath filesep 'Clusters' filesep D(3).name]);

if subj==1
    
    k=1;
    X=char(D(3:end,1).name);
    Y=str2num(X(:,4:5));
    for i=1:length(tmp_names)
        n_selClusters(i)=nnz(Y==tmp_names(i));
    end
    
    vec=[];
    class_without_zeros=class;
    class_without_zeros(class_without_zeros==0)=[];
    for i=1:length(tmp_names)
        vec=[vec class_without_zeros(i)*ones(1,n_selClusters(i))];
    end
    
end

mask=zeros(91,109,91,length(tmp_names));
n=1;
m=1;
if subj==1
    k=1;
    for i=3:length(D)
        if nnz(str2num(D(i).name(4:5))==tmp_names)
            if ~nnz(k==exc)
                VallROIs=spm_vol([workPath filesep 'Clusters' filesep D(i).name]);
                Clusters=spm_read_vols(VallROIs); % read nodes templates
                zica=compImage(:,:,:,vec(k));
                zica=Clusters.*zica;
                
                % maximum z value inside the cluster
                idx2=find(Clusters>.5);
                
                [peak_value(k) idx3(k)]=max(zica(idx2));
                [x(k) y(k) z(k)]=ind2sub(size(zica),idx2(idx3(k)));
                x(k)=91-x(k)+1;
                [MNIx(k) MNIy(k) MNIz(k)] = mni2orFROMxyz_noprint(x(k),y(k),z(k),2,'xyz');
                
                [firstValue,idx3]=sort(zica(idx2),'descend');
                
                n_vox_total=nnz(Clusters);
                if n_vox_total/10<120
                    n_vox=120;
                else
                    n_vox=n_vox_total/10;
                end
                
            end
            
            if k~=1
                if vec(k)~=vec(k-1)
                    n=n+1;
                    m=1;
                end
            end
            
            if peak_value(k)>=0.1
                if sep == 1
                    im=m*(zica>=firstValue(round(n_vox)));
                    mask(:,:,:,n)=mask(:,:,:,n)+im;
                    m=m+1;
                else
                    im=zica>=firstValue(round(n_vox));
                    mask(:,:,:,n)=mask(:,:,:,n)+im;
                end
            end
            k=k+1;
        end
    end
else
    k=1;
    for i=3:length(D)
        if nnz(str2num(D(i).name(4:5))==tmp_names)
            D2(i-2,:)=D(i).name;
        end
    end
    
    j=1;
    for i=1:size(D2,1)
        if D2(i,1)=='R'
            D3(j,:)=D2(i,:);
            j=j+1;
        end
    end
    
    D3(exc,:)=[];
    
    for i=1:size(D3,1)
        VallROIs=spm_vol([workPath filesep 'Clusters' filesep D3(i,:)]);
        Clusters=spm_read_vols(VallROIs); % read nodes templates
        zica=compImage(:,:,:,vec(i));
        zica=Clusters.*zica;
        
        idx2=find(Clusters>.5);
        
        [peak_value(i) idx3(i)]=max(zica(idx2));
        [x(i) y(i) z(i)]=ind2sub(size(zica),idx2(idx3(i)));
        x(i)=91-x(i)+1;
        [MNIx(i) MNIy(i) MNIz(i)] = mni2orFROMxyz_noprint(x(i),y(i),z(i),2,'xyz');
        
        [firstValue,idx3]=sort(zica(idx2),'descend');
        
        n_vox_total=nnz(Clusters);
        if n_vox_total/10<120
            n_vox=120;
        else
            n_vox=n_vox_total/10;
        end
        
        if k~=1
            if vec(k)~=vec(k-1)
                n=n+1;
                m=1;
            end
        end
        
        if peak_value(k)>=0.1
            if sep == 1
                im=m*(zica>=firstValue(round(n_vox)));
                mask(:,:,:,n)=mask(:,:,:,n)+im;
                m=m+1;
            else
                im=zica>=firstValue(round(n_vox));
                mask(:,:,:,n)=mask(:,:,:,n)+im;
            end
        end
        k=k+1;
    end
    
end

if subj==1
    exc=find(peak_value<0.1); % eliminate points when low peaks are found
    peak_value(exc)=[];
    x(exc)=[];
    y(exc)=[];
    z(exc)=[];
    MNIx(exc)=[];
    MNIy(exc)=[];
    MNIz(exc)=[];
    vec(exc)=[];
end

mask=flipud(mask);
    
return
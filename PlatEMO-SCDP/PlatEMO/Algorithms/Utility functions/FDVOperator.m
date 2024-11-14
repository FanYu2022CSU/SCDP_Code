function OffDec = FDVOperator(Problem,OffDec,stage)
    %% Fuzzy Evolution Sub-stages Division
    % Step=[0 0.6 0.8 0.8];

    v_min=min(min(OffDec));
    v_max=max(max(OffDec));
    v_t=(OffDec-v_min)./(v_max-v_min+1e-8);%��һ��
    %     v_t0=v_t;

    %% Fuzzy  v_t
    i=max(1,stage);%�����Ǳ���һλС��
    lower=zeros(1,Problem.D);
    upper=ones(1,Problem.D);
    R=upper-lower;
    gamma_a = R*10^-i.*floor(10^i*R.^-1.*(v_t-lower)) + lower;
    gamma_b = R*10^-i.*ceil(10^i*R.^-1.*(v_t-lower)) + lower;
    miu1    = 1./(v_t-gamma_a);
    miu2    = 1./(gamma_b-v_t);
    logical = miu1-miu2>0;%�����׳�������Ϊ0�ú�С����ֵ��ʾ
    v  = gamma_b;
    v(find(logical)) = gamma_a(find(logical));

    %% Restoration variable
    OffDec=v.*(v_max-v_min+1e-8)+v_min;
end
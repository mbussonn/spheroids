%%

function val = testrad()



    %%
    data = read_mixed_csv('E14 2013-08-13.csv',',');

    s = size(data);


    times = [];
    for i=3:s(2)
        times = [times  eval(data{1,i})];
    end



    fluo = zeros(s(1)-1,s(2)-2);


    pixels = []
    for i=3:s(2)
        
        for j=2:s(1)
            fluo(j-1,i-2) = eval(data{j,i});
        end
    end

    fluo = bsxfun(@minus, fluo, min(fluo));
    
    nfluo = bsxfun(@rdivide, fluo, max(fluo));

    csfluo = cumsum(fluo);

    normalized_cs_fluo = bsxfun(@rdivide, csfluo, max(csfluo));

    %%
    figure(1)
    plot(bsxfun(@rdivide, csfluo, max(csfluo)));
    xlim([0 150])
    
    
    
    %%
    figure(2)
    clf
    hold on 
    for k = 0.1:0.05:0.95
        [v,i] = min(abs(normalized_cs_fluo-k));
        plot(i)
    end

    %%
    figure(3)
    clf
    hold on
    jj= 1:s(2)-2;
    clr = 'rgbky';
    cprct = [];
    for j = jj
        ii = 1:6:71;
        mii = [];
        for i = 15
            smoothed = slidingavg(nfluo(:,j),i);
            [m,mi] = max(smoothed);
            clc = clr(mod(j,5)+1);
            ccs = cumsum(smoothed)
            
            plot((1:375)-mi,(ccs-ccs(mi))/max(ccs-ccs(mi)), clc)
            mii = [mii mi];
            cprct = [cprct  normalized_cs_fluo(mi,j)];

        end
        %plot(ii, mii,'+--')
    end
    xlim([00 100])
    %%
    figure(4)
    plot(cprct)

    %ylim([0,120])
    %%
    px = data(:,2);
    figure(1)
    hold on;

    fp = []
    for i = 3:25
      d = data(:,i);
      r = d/max(d);

      plot(px, r);
      fpl = [];
      for tressh = (1:9)/10
          [v,i] = min(arrayfun(@(x)abs(x),r-tressh));
          fpl = [fpl ; px(i)];
      end
      fp  = [fp fpl];

    end
    hold off

    figure(2)

    plot(fp')
end



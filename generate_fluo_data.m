% Generate phony fluo data
% to test analysis program
% Nothing fancy

function res = generate_fluo_data()
    
    res = [];
    f = @(x,t) (x./t).^2.*exp(-x./t);

    x= 0:0.1:10;
    for t=0.1:1:5

        g=@(x)f(x,t^2/10)+rand(size(x))/50; 
        res = [res;g(x)];
    end
    res = res'; 
end
    

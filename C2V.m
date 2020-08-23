% function v=C2V(c)
%     v =[];
%     for s=1:length(c)
%         for w=1:length(c{s})
%             v = [v(:);c{s}{w}(:)];
%         end
%     end
% end


function v=C2V(c)
    v =zeros(1500000,1);
    f0 = 1;
    for s=1:length(c)
        for w=1:length(c{s})
            n = numel(c{s}{w});
            v(f0:f0+n-1) = c{s}{w}(:);
            f0 = f0+n;
        end
    end
    v(f0:end)  = [];
end
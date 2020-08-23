function c=V2C(v,ct)
    c = ct;
    p = 1;
    for s=1:length(ct)
        for w=1:length(ct{s})
            c{s}{w}(:) = v(p:p+numel(ct{s}{w})-1);
            p = p+numel(ct{s}{w});
        end
    end
end
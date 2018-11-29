function is_end_point = endpoint_fcn(nhood)
    is_end_point = nhood(2,2) & sum(nhood(:)) == 2;
end


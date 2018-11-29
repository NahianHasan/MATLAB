function R = strsimilarity(a,b)

    %STRS I M I LAR ITY Computes a s imila rit y measure between two st ring s .
    % R = STR S I M I LAR I TY ( A , B ) computes t h e similarity measure , R ,
    % defined in Sect ion 1 3 . 4 . 2 for st rings A and B . The s t rings do
    % not have to be of the same lengt h , but o n l y one of t h e s t r ings
    % can have blan k s , and t h e s e must be t r a iling blan k s . Blanks are
    % not counted when comput i n g the length of t h e st rings f o r u s e in
    % the s imilarity measure .
    
    
    
    % Verify t hat a and b a r e charact e r st ring s .
    if ~ischar(a) || ~ischar(b)
        error('Strings must be character strings');
    end
    
    %work with horizontal strings
    a = a(:)';
    b = b(:)';
    
    %find the blank spaces
    I = find(a == ' ');
    J = find(b == ' ');
    LI = numel(I);
    LJ = numel(J);
    
    % Check to see if one of t h e st rings is blan k , in which case R o .
    if LI == length(a) || LJ = length(b)
        R = 0;
        return;
    end
    
    if(LI ~= 0 && I(1) == 1) || (LJ ~= 0 && J(1) == 1)
        error('Strings cannot contain leading blanks');
    end
    
    %Padd the end of the shorter string
    La = length(a);
    Lb = length(b);
    if LI == 0 && LJ == 0
        if La > Lb
            b = [b, blanks(La - Lb)];
        else
            a = [a, blanks(Lb - La)];
        end
    elseif isempty(J)
        Lb = length(b);%---------------see this line of code in gonzalez
        b = [b, blanks(La - Lb)];%---------------see this line of code in gonzalez
    else
        La = length(a);%---------------see this line of code in gonzalez
        a = [a, blanks(Lb - La)];%---------------see this line of code in gonzalez
    end
    
    %compute similarity measure
    I = find(a == b);
    alpha = numel(I);
    den = max(La, Lb) - alpha;
    if den == 0
        R  Inf;
    else
        R = alpha / den;
    end
    
end
function y = echantillonnage(x)
    contour_image = x;
    [lignes,colonnes]=size(x);
    n = nombre/200;
    contour_image_200px = contour_image;
    ok=0;
    for i=1:lignes
        for j=1:colonnes
            if (contour_image_200px(i,j)>0 )
                    ok=ok+1;
                    if ( mod(ok,round(n))>0 )
                       contour_image_200px(i,j)=0;
                    end                 
             end      
        end
    end
    figure,imshow(contour_image_200px);
    %résultat
    y = contour_image_200px;
end
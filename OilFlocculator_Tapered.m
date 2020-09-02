    clear
    %Variables
    %Note that code works only for m=3 or larger
    
    G=[0.5 0.4 0.3 0.2 0.1];    %s^-1
    V=[50 75 100 125 150];  %m^3
    m=length(G);
    K_a=5.23*10^-5;     
    K_b=4.95*10^-5;   %s^-1 
    q=0.05/10;  
    
    

    %Calculate Numerator
    Numerator=1;
    for i=1:m
        Numerator=Numerator*(1+K_a*G(i)*V(i)/q);
    end
    
    %Calculate Denominator
    Denominator_matrix=ones(1,m+1);
    Denominator_matrix(2)=K_b*G(1)^2*V(1)/q;
    
    %Creates base terms for denominator without (1+K_aG(i)V(i)/q)
    for i=3:m+1
        Denominator_matrix(i)=K_b*G(i-1)^2*V(i-1)/q;
    end
    
    %Multiplies (1+K_aG(j)V(j)/q) to the appropriate terms
    for i=3:m+1
        for j=1:i-2
            Denominator_matrix(i)=Denominator_matrix(i)*(1+K_a*G(j)*V(j)/q);
        end
    end
    
    %Calculates denominator
    Denominator=sum(Denominator_matrix);
    
    %Calculates oil ratio n_o/n_m
    Numerator
    Denominator_matrix
    Oilratio=Numerator/Denominator
    OilFractionalRemainder=1/Oilratio
        
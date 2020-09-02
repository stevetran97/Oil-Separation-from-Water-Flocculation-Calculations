    clear
    clc
    %Variables
    %Note that code works only for m=3 or larger
    m=5;
    K_a=5.23*10^-5;     
    K_b=4.95*10^-5;   %s^-1
    q=0.05/10;        %m^3/s
    G=[0.1];  %s^-1
    V=[10];  %m^3
    deltaG=0.1;
    deltaV=10;
    n_design_G=10;
    n_design_V=5;
    
    %Define possible design parameters
    for h=2:n_design_G
        G(h)=G(1)+(h-1)*deltaG;  %s^-1
    end
    
     %Define possible design parameters
    for h=2:n_design_V
        V(h)=V(1)+(h-1)*deltaV; %m^3
    end
    

    %Define Oil Ratio Results
    Oilratio=ones(length(G),length(V));
    
    %Calculates oil seperation results for all given configurations
    for k=1:length(G)
        for l=1:length(V)
            %Calculate Numerator
            Numerator=(1+K_a*G(k)*V(l)/q)^m;


            %Calculate Denominator
            Denominator_matrix=ones(1,m+1);
            Denominator_matrix(2)=K_b*G(k)^2*V(l)/q;

            %Creates base terms for denominator without (1+K_aG(k)V(l)/q)
            for i=3:m+1
                Denominator_matrix(i)=K_b*G(k)^2*V(l)/q;
            end

            %Multiplies (1+K_aG(k)V(l)/q) to the appropriate terms
            for i=3:m+1
                for j=1:i-2
                    Denominator_matrix(i)=Denominator_matrix(i)*(1+K_a*G(k)*V(l)/q);
                end
            end

            %Calculates denominator
            Denominator=sum(Denominator_matrix);

            %Calculates oil ratio n_o/n_m
            Numerator;
            Denominator_matrix;
            Oilratio(k,l)=Numerator/Denominator;
            FractionalOilRemainder=Oilratio.^-1
        end 
    end
     
    V
    G
    Oilratio
    %Plot Data
    mesh(V,G,FractionalOilRemainder)
    xlabel("Volume (m^3)")
    ylabel("G (s^-1)")
    zlim([0 1])
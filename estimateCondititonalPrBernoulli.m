function Pr_ItemInCategory = estimateCondititonalPrBernoulli(Pr_UratedC, R)
    Nitems = size(R,2);                 %number of items
    
    Nusers = size(Pr_UratedC, 1);       %number of users
    Ncategories = size(Pr_UratedC, 2);  %number of genres
    Nrates = size(Pr_UratedC, 3);       %number of rates
    
    % Estimate conditional probability of Item i given Class c
    Pr_ItemInCategory = zeros(Nitems, Ncategories, Nrates); % allocate memory
    Pr_ItemInCategory_temp = zeros(Nitems, 1);
    for r = 1:Nrates
        R_temp = (R == r);
        for c = 1:Ncategories
            Pr_UratedC_temp = Pr_UratedC(:,:,r);
            %ind = find(G(:,c) ~= 0);
            %ind = 1:Nitems;
            for i = 1:Nitems
                %Pr_ItemInCategory_temp(ind(i)) =  prod(R_temp(:,ind(i)) .* Pr_UratedC_temp(:,c) + (1 - R_temp(:,ind(i))) .* (1 - Pr_UratedC_temp(:,c)));
                Pr_ItemInCategory_temp(i) =  sum(log(R_temp(:,i) .* Pr_UratedC_temp(:,c) + (1 - R_temp(:,i)) .* (1 - Pr_UratedC_temp(:,c))));
            end
            Pr_ItemInCategory(:, c, r) = Pr_ItemInCategory_temp;
        end   
    end

end
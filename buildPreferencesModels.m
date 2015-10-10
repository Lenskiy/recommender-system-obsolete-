%R is the utility matrix
%G is the categoy matrix, for every items it contains what catergory it belongs to
function p_UiRatedCkasK = buildPreferencesModels(R, G);
    Nusers = size(R,1);     %number of users
    Nitems = size(R,2);     %number of items
    Ngenres = size(G,2);    %number of genres
    Nrates = max(max(R));   %number of rates

    for i = 1:Nusers
       ratedItems = find(R(i,:) > 0); % indexes of items that were rated by user i
       NratedItems = length(ratedItems); %number of rated items by user i
       for k = 1:Ngenres
           itemsIndexesRatedBy_iInCK = find(G(ratedItems,k) > 0); % item indexes rated by a user i that belong to category k
           ratedItemsByiInCk = R(i,ratedItems(itemsIndexesRatedBy_iInCK)); % ratings of the rated items
           %length(find(ratedItemsByiInCk == 0)) > 0; %<--- should be always false
           for r = 1:Nrates
                ratingsHistByiInCk(r) = length(find(ratedItemsByiInCk == r)); % calculate the histogram
           end  
           if(sum(ratingsHistByiInCk) == 0) continue; end;%<--- should not be like this
           p_UiRatedCkasK(i, k, :) = ratingsHistByiInCk / sum(ratingsHistByiInCk); %/Nitems;
       end
       for j = 1:Nrates
           s = sum(p_UiRatedCkasK(i,:,j));
           if s ~= 0
               p_UiRatedCkasK(i,:,j) = p_UiRatedCkasK(i,:,j) / s;
           end
       end
    end
end
%figure, hold on; stem(R(i,:))
%stem(ratedItems(itemsIndexesRatedBy_iInCK), R(i,ratedItems(itemsIndexesRatedBy_iInCK)), 'r')
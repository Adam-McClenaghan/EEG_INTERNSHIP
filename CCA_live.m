%% Compute canonical correlation values
   
    for i = 1:length(roi)
        CCA_data(:,i) = Data_arr(:,roi(i));
    end

    num_inputs = length(stimfreq);
    %  r = zeros(num_inputs,length(roi));

    for d = 1:num_inputs
    %     [A,B,r(d,:)] = canoncorr(Input_1,compmat(:,:,d)');
        [A,B,r] = canoncorr((CCA_data),compmat(:,:,d)');
        r_tot(d) = sum(r);
    end


%     [A,B,r(d,:)] = canoncorr(Input_1,compmat(:,:,d)');
%     [A,B,r] = canoncorr(Input_1,compmat(:,:,8)');



% r_tot = sum(r,2);
[result,position] = max(r_tot);
probable_input = stimfreq(position);

disp(probable_input)

if max(r_tot) > 1.5 * mean(r_tot)
% %     
    disp(r_tot)
%     disp(probable_input)
else
    disp('Undefined guess')
    % writematrix(probable_input, 'C:\Users\Adam\Documents\MENG_yr3\IRP_papers\pytest.csv')
end
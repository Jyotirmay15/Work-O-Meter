function [] = updateVariables(app, bbox)
% This function updates the variables and sounds the alarm if TLE occurs for break or Working 
%   Detailed explanation goes here
        if((nnz(bbox))==0)
            disp('No Face detected');

            app.Timer_absent = app.Timer_absent + app.Interval;
            app.curr_absent = app.curr_absent + app.Interval;

            if (app.curr_absent> app.Curr_time_absent_limit)
                app.Timer_Present = 0;
                app.curr_absent = 0;
            end  
        else
            disp('Face detected');
            app.Timer_Present = app.Timer_Present + app.Interval;
            app.Timer_absent = 0;
        end

        %Warning display If time limit exceeds go in a loop till face not
        %found
        if app.Timer_Present > app.Time_present_limit
            if nnz(bbox) ~= 0
                while true
                    warndlg('Please take a short break', 'WORK CAPACITY FULL', app.warningDialog);
                    playAlarm(app);
                    [inputImage, fname] = capture(app.vid);
                    [OutputImage, bbox] = detectFace(inputImage, fname);
                    if nnz(bbox) == 0
                        break;
                    end
                    imshow(OutputImage, 'parent', app.UIAxes2);
                    pause(app.Interval)
                    app.Timer_Present = app.Timer_Present + app.Interval;
                    app.Label.Text = sprintf('Total Absence till last break  %d \n Total Presence %d\n', app.Timer_absent, app.Timer_Present);
                    drawnow;
                end
            else
                app.Timer_Present = 0;
                app.Timer_absent = app.Interval;
                pause(app.player);
                app.Label.Text = sprintf('Total Absence till last break  %d \n Total Presence %d\n', app.Timer_absent, app.Timer_Present);
                drawnow;
            end
        end
        
        % If break limit exceeds go in a loop till a face is found
        if app.Timer_absent> app.Time_absent_limit
            if nnz(bbox) == 0
                 while true
                    warndlg('You have exceed your break time limit, PLease get back to work', 'GET BACK NOW', app.warningDialog);
                    playAlarm(app);
                    [inputImage, fname] = capture(app.vid);
                    [OutputImage, bbox] = detectFace(inputImage, fname);
                    if nnz(bbox) == 0
                        break;
                    end
                    imshow(OutputImage, 'parent', app.UIAxes2);
                    pause(app.Interval)
                    app.Timer_absent = app.Timer_absent + app.Interval;
                    app.Label.Text = sprintf('Total Absence till last break  %d \n Total Presence %d\n', app.Timer_absent, app.Timer_Present);
                    drawnow;
                end
            else
                app.Timer_absent = 0;
                app.Timer_Present = app.interval;
                app.Label.Text = sprintf('Total Absence till last break  %d \n Total Presence %d\n', app.Timer_absent, app.Timer_Present);
                drawnow;
                pause(app.player);
            end
        end
        
        string = sprintf('Total Absence till last break  %d \n Total Presence %d\n', app.Timer_absent, app.Timer_Present);
        app.Label.Text = string;
        fprintf ('%s\n', string);
end


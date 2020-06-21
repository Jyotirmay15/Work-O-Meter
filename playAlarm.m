function [] = playAlarm(app)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if app.alarm
    disp("Playing Alarm sound");
    play(app.player);
end
end


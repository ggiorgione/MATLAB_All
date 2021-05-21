% Google Example by Alex Geiger

% search google for us income
s = google('US Income');

% check out the answer
fprintf('\n\ndisplay the google functions answer:\n')
disp(s.answer)

% obtain the answer note s is a structure and so is answer
US_Income = s.answer.answer;
Date = s.answer.date;

fprintf('\nin %0.0f the US Income was $%0.0f \n\n',Date,US_Income)


% show top link
disp(s.links{1})
 
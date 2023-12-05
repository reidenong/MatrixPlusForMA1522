function rowNum = gRow(string)
newString = strip(string, 'R');
rowNum = str2num(newString);
end
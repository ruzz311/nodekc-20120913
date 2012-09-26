self.addEventListener('message', 
  (e)->
    cycles = e.data;
    postMessage("Calculating Pi using " + cycles + " cycles");
    numbers = calculatePi(cycles);
    postMessage("Result: " + numbers);
    return true,
  false);

calculatePi = (cycles)->
  var pi = 0
  var n  = 1
  for (i=0; i <= cycles; i++)
    pi = pi + (4 / n) - (4 / (n + 2));
    n  = n  + 4;
  return pi;
import { open } from 'node:fs/promises';

const file = await open('./data');

const calories = [];
let currentElfCalories = 0;

for await (const line of file.readLines()) {
  if (line.trim() === '') {
    calories.push(currentElfCalories);
    currentElfCalories = 0;
  } else {
    const calories = parseInt(line, 10);
    currentElfCalories += calories;
  }
}
calories.push(currentElfCalories);
calories.sort((a, b) => b - a);

const [top1, top2, top3] = calories;
console.log(top1, top1 + top2 + top3);

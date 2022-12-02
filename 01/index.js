import { open } from 'node:fs/promises';

const file = await open('./data');

let currentElfCalories = 0;
let maxCalories = 0;

for await (const line of file.readLines()) {
  if (line.trim() === '') {
    maxCalories = Math.max(currentElfCalories, maxCalories);
    currentElfCalories = 0;
  } else {
    const calories = parseInt(line, 10);
    currentElfCalories += calories;
  }
}

console.log(maxCalories);

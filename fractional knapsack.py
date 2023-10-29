
num_of_items = int(input("Enter number of items: "))
max_weight = int(input("Enter max weight of knapsack: "))
items = []
for i in range(num_of_items):
    profit = int(input("Enter profit of item "))
    weight = int(input("Enter weight of item "))
    ratio = profit/weight
    items.append((profit, weight, ratio))

items.sort(key=lambda x: x[2], reverse=True)
total_profit = 0
for item in items:
    profit, weight, ratio = item
    if weight <= max_weight:
        total_profit += profit
        max_weight -= weight
    else:
        total_profit += ratio*max_weight
        break
print(f"Total profit obtained:{total_profit}")

import re, copy, bisect, time

job_time = time.clock()

guesses = """
 5616185650518293 ;2 correct
 3847439647293047 ;1 correct
 5855462940810587 ;3 correct
 9742855507068353 ;3 correct
 4296849643607543 ;3 correct
 3174248439465858 ;1 correct
 4513559094146117 ;2 correct
 7890971548908067 ;3 correct
 8157356344118483 ;1 correct
 2615250744386899 ;2 correct
 8690095851526254 ;3 correct
 6375711915077050 ;1 correct
 6913859173121360 ;1 correct
 6442889055042768 ;2 correct
 2321386104303845 ;0 correct
 2326509471271448 ;2 correct
 5251583379644322 ;2 correct
 1748270476758276 ;3 correct
 4895722652190306 ;1 correct
 3041631117224635 ;3 correct
 1841236454324589 ;3 correct
 2659862637316867 ;2 correct
"""

mask = re.compile("(\d+)\D*(\d+)")

class Rule:
    def __init__(self, line):
        a, b = mask.search(line).groups()
        self.guess = [int(x) for x in a]
        self.correct = int(b)
        self.count = len(a)

    def __cmp__(self, other):
        if self.correct * other.count != other.correct * self.count:
            return other.correct * self.count - self.correct * other.count
        elif self.correct != other.correct:
            return other.correct - self.correct
        elif self.count != other.count:
            return self.count - other.count
        else:
            for i, n in enumerate(self.guess):
                if n != other.guess[i]:
                    return other.guess[i] - n
        return 0

    def __repr__(self):
        return str(self.correct) + ", " + str(self.count) + ", " + str(self.guess)

class InvalidRuleException:
    pass

class Answer:
    def __init__(self, numbers):
        self.number = "".join([str(n[0]) for n in numbers])

class Solution:
    def __init__(self, guesses):
        self.rules = [Rule(x) for x in guesses.strip().splitlines()]
        self.rules.sort()
        self.valid_rules = []
        self.empty_rules = []
        self.numbers = [range(10) for x in range(self.rules[0].count)]

    def cast_rule(self, pos):
        rule = self.rules[pos]
        if rule.correct > rule.count:
            raise InvalidRuleException()
        elif rule.correct == 0:
            if pos not in self.empty_rules:
                bisect.insort(self.empty_rules, pos)
        elif rule.correct == rule.count:
            if pos not in self.valid_rules:
                bisect.insort(self.valid_rules, pos)
        
    def remove_valid_number(self, row, number):
        if number not in self.numbers[row]: raise InvalidRuleException()
        self.numbers[row] = [number]

        for i, rule in enumerate(self.rules):
            if rule.guess[row] >= 0:
                if rule.guess[row] == number:
                    rule.correct -= 1
                rule.guess[row] = -1
                rule.count -= 1
                self.cast_rule(i)

    def remove_invalid_number(self, row, number):
        if number in self.numbers[row]:
            self.numbers[row].remove(number)
            if not self.numbers[row]: raise InvalidRuleException()
        for i, rule in enumerate(self.rules):
            if rule.guess[row] >= 0 and rule.guess[row] == number:
                rule.guess[row] = -1
                rule.count -= 1
                self.cast_rule(i)

    def remove_valid_rules(self):
        while self.valid_rules:
            i = self.valid_rules[0]
            for row, number in enumerate(self.rules[i].guess):
                if number >= 0:
                    self.remove_valid_number(row, number)
            self.valid_rules.remove(i)

    def remove_empty_rules(self):
        while self.empty_rules:
            rule = self.rules.pop(self.empty_rules.pop())
            for row, num in enumerate(rule.guess):
                if num >= 0:
                    self.remove_invalid_number(row, num)

    def get_empty_rules(self):
        for i, rule in enumerate(self.rules):
            if rule.correct == 0:
                self.empty_rules.append(i)

def test_number(solution, row, number):
    solution = copy.deepcopy(solution)
    solution.remove_valid_number(row, number)
    while solution.empty_rules or solution.valid_rules:
        solution.remove_valid_rules()
        solution.remove_empty_rules()
    
    if solution.rules:
        solution.rules.sort()
        rule = solution.rules[len(solution.rules) - 1]  # get the last rule
        if rule.correct == 1:
            for row, number in enumerate(rule.guess):
                if number >= 0:
                    try: test_number(solution, row, number)
                    except InvalidRuleException: pass
        else: pass
    else:
        # no more rules left. the number should be valid.
        raise Answer(solution.numbers)


sol = Solution(guesses)

sol.get_empty_rules()
sol.remove_empty_rules()
sol.rules.sort()

rule = sol.rules[len(sol.rules) - 1]
for row, num in enumerate(rule.guess):
    if num >= 0:
        try: test_number(sol, row, num)
        except InvalidRuleException: pass
        except Answer as ans:
            print("problem #185. The unique 16-digit secret sequence:", ans.number, ans.number == "4640261571849533")
            break

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))

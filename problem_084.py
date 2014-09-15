import random, time, math

job_time = time.clock()

# board = [ { 'position':0, 'name':'GO', 'probability':2.5 } ]
# print board

# class Square:
    # def __init__(self, position, name):
        # self.position = position
        # self.name = name
        # self.visit_count = 0

# board = [ Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO'),
          # Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO'),
          # Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO'), Square(0, 'GO') ]
#print board

DICE_SIDES = 6

GO = 0

CC1 = 2
CC2 = 17
CC3 = 33

CH1 = 7
CH2 = 22
CH3 = 36

C1 = 11
E3 = 24
H2 = 39

R1 = 5 # railway company
R2 = 15
R3 = 25
R4 = 35

U1 = 12 # utility company
U2 = 28

JAIL = 10
GTJ = 30 # go to jail

BOARD_SIZE = 40

board = [0] * BOARD_SIZE
# print board

STAY = -1
BACK_3 = -3 # go back 3 squares
NEXT_R = -4 # go to next railway company
NEXT_U = -5 # go to next utility company

community_chest = [GO, JAIL, STAY, STAY, STAY, STAY, STAY, STAY, STAY, STAY,
                   STAY, STAY, STAY, STAY, STAY, STAY]

chances = [GO, JAIL, C1, E3, H2, R1, NEXT_R, NEXT_R, NEXT_U, BACK_3,
           STAY, STAY, STAY, STAY, STAY, STAY]

def next_move(game):
    dice_a = random.randint(1, DICE_SIDES)
    dice_b = random.randint(1, DICE_SIDES)
    if dice_a == dice_b:
        # if a player rolls three consecutive doubles,
        # they do not advance the result of their 3rd roll.
        # Instead they proceed directly to jail.
        game.doubles += 1
        if game.doubles > 2:
            game.doubles = 0
            game.position = JAIL
            return
    game.position = (game.position + dice_a + dice_b) % BOARD_SIZE

    if game.position in (CH1, CH2, CH3):
        game.chance_index = (game.chance_index + 1) % len(chances)
        pos = chances[game.chance_index]
        if pos >= 0:
            game.position = pos
            assert(game.position < BOARD_SIZE)
            return
        elif pos == BACK_3:
            game.position = (game.position + BOARD_SIZE - 3) % BOARD_SIZE
            #return
        elif pos == NEXT_R:
            while game.position not in (R1, R2, R3, R4):
                game.position = (game.position + 1) % BOARD_SIZE
            return
        elif pos == NEXT_U:
            while game.position not in (U1, U2):
                game.position = (game.position + 1) % BOARD_SIZE
            return
        else:
            assert(pos == STAY)
            return

    if game.position in (CC1, CC2, CC3):
        game.community_chest_index = (game.community_chest_index + 1) % len(community_chest)
        pos = community_chest[game.community_chest_index]
        if pos != STAY:
            game.position = pos
        return

    if game.position == GTJ:
        game.position = JAIL
        return

class Monopoly:
    def __init__(self):
        self.position = GO
        self.doubles = 0
        self.chance_index = -1
        self.community_chest_index = -1

    def __str__(self):
        return 'position=%i, doubles=%i chance_index=%i community_chest_index=%i' % (self.position, self.doubles,
            self.chance_index, self.community_chest_index)

m = Monopoly()
board[m.position] += 1
for i in xrange(10**6):
    next_move(m)
    board[m.position] += 1

s = sorted(board[:], reverse = True)

print m
print board
print s
print board.index(s[0]), board.index(s[1]), board.index(s[2])

print("problem #84.")

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))


from pyOpenBCI import OpenBCICyton
import time

# running = True

def print_raw(sample):
     print(sample.channels_data)
    #  running = False
    
    # if running == False:
    #     return
    

board = OpenBCICyton(daisy = True)

board.write_command('b')

def data(sample):
    data = sample.channels_data

data(sample)
time.sleep(3)

board.write_command('s')

# board.start_stream(print_raw)
# board.write_command('b')

# Timer = time
# if Timer >= 3:
#     running = False


# board.stop_stream()

print('Test Complete')
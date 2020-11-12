"""
	Code to giving automated feedback on computing practical work for TheMulQuaBio

	USAGE 
	
	python3 Feedback.py StudentsFile RepoPath Week

	or, if ready to git push: 
	
	Feedback.py StudentsFile RepoPath Week --gitpush 

	example: python3 Feedback.py ~/Documents/Teaching/IC_CMEE/2019-20/Students/Students.csv ~/Documents/Teaching/IC_CMEE/2019-20/Coursework/StudentRepos Week1

	ARGUMENTS: 

	Week		  : Name of week to assess (Week1, Week2, etc.)

"""
# TODO: 
# * Hard-code include a dictionary that has names of weekly code files to
#   compare against
# * Bug: week 1, but also 10 will end up being assessed if it exists - fix
# * Allow Week to be set to 0 for only git checking out
# * Call a warning a warning and error an error!
# * Count up lines of code in each script and report it
# * Include a weekly list of expected code files to check against?
# * Include "using repository state at time..."?
# * Allocate points to each expected and independent code file as weighted
#   percent of 100, weight determined by number of code lines; Update marking
#   criteria accordingly; Total baseline points are weighted average of these
#   two, from   which additional points are deleted for poor project
#   organization, readme,  etc.

import subprocess, os, argparse, re, sys, shutil

def run_popen(command, timeout):
    """Runs a sub-program in subprocess.Popen using the given COMMAND and
    TIMEOUT (seconds).
    """
    import time
    start = time.time()
    p = subprocess.Popen(f'{command}', shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = p.communicate(timeout=timeout)
    end = time.time()

    return p, stdout.decode(), stderr.decode(), (end - start) # decode: binary --> string

################################################
################ Main Code #####################		
################################################

#TODO: create Assessment Script in CWD (automatically into assessment folder)
# Then cleanup (delete cloned repo)

# set up the argument parser 
parser = argparse.ArgumentParser("Assesses CMEE Masters weekly computing practical work")

# positional argument inputs
parser.add_argument("Week", help="Name of week to assess (Week1, Week2, etc.)")
args = parser.parse_args()

#Clone Repo
subprocess.check_output(["git","clone", 'https://github.com/zongyi2020/CMEECourseWork', 'CLONE_CMEE'])

ignore_files = [".log",".csv",".pdf"] # files to ignore in all directories

repo_dh = subprocess.run(['du', '-sh', 'CLONE_CMEE/.git'], stdout=subprocess.PIPE)
RepoSize = str(repo_dh.stdout)[2:].split('\\')[0] #store repo size
scrptPath = os.path.dirname(os.path.realpath(__file__)) #store assessment script path
timeout = 10 #set time out for each script's run (integer seconds)
charLim = 500 #set limit to output of each script's run to be printed

Name = 'zongyi2020'
RepoPath = f'{scrptPath}/CLONE_CMEE/'
AzzPath = scrptPath

Points = 100

#~ Now open assessment directory inside repository:

if not os.path.exists(AzzPath):
	os.makedirs(AzzPath)

#~ Open assessment file:
azzFileName = args.Week + '_'+'Feedback.txt'
azz = open(AzzPath + '/'+ azzFileName,'w+')
# if not os.path.exists(AzzPath + '/'+ azzFileName):
	# azz = open(AzzPath + '/'+ azzFileName,'w+')
# else:
	# print('\nAssesment file for ' + args.Week+  ' already exists, cannot continue! Check and delete existing file and try again.\n\n')
	# break
print('='*70 + '\n' + 'Starting weekly assessment for '+ 'zongyi Sun' + ', ' + args.Week +'\n' + '='*70 + '\n\n')

azz.write('Starting weekly assessment for '+ 'zongyi' + ', ' + args.Week +'\n\n')
azz.write('Current Points = ' + str(Points) + '\n\n')
azz.write('Note that: \n')
azz.write('(1) Major sections begin with a double "====" line \n')
azz.write('(2) Subsections begin with a single "====" line \n')
azz.write('(3) Code output or text file content are printed within single "*****" lines \n\n')

####################################################
azz.write('='*70 + '\n')
azz.write('='*70 + '\n')

azz.write(f'Your Git repo size this week is about {RepoSize} on disk \n\n')

azz.write('PART 1: Checking project workflow...\n\n')
DirCont = os.listdir(RepoPath)
TempDirs = [name for name in DirCont if os.path.isdir(RepoPath+'/' + name)]
TempFiles = [name for name in DirCont if os.path.isfile(RepoPath+'/' + name)]
azz.write('Found the following directories in parent directory: '\
 + ', '.join(TempDirs) + '\n\n')
azz.write('Found the following files in parent directory: '\
 + ', '.join(TempFiles) + '\n\n')

#~ Begin assessment:
azz.write('Checking for key files in parent directory...\n\n')
if '.gitignore' in TempFiles:
	azz.write('Found .gitignore in parent directory, great! \n\n')
	azz.write('Printing contents of .gitignore:\n')
	g = open(RepoPath + '/.gitignore', 'r')
	azz.write('*'*70 + '\n')
	for line in g:
		azz.write(line,)
	azz.write('*'*70 + '\n\n')
else:
	azz.write('.gitignore missing, 1 pt deducted\n\n')
	Points = Points - 1
	azz.write('Current Points = ' + str(Points) + '\n\n')

readme = 'n'
for name in TempFiles:
	if 'readme' in name.lower() and not '~' in name.lower():
		azz.write('Found README in parent directory, named: ' + name + '\n\n')
		azz.write('Printing contents of ' + name + ':' + '\n')
		g = open(RepoPath + '/' + name, 'r')
		azz.write('*'*70 + '\n')
		for line in g:
			azz.write(line,)
		azz.write('*'*70 + '\n\n')
		readme = 'y'
		break
if readme == 'n':
	azz.write('README file missing, 1 pt deducted\n\n')
	Points = Points - 1
	azz.write('Current Points = ' + str(Points) + '\n\n')

azz.write('='*70 + '\n')
azz.write('Looking for the weekly directories...' + '\n\n')

WeekDirs = [name for name in TempDirs if 'week' in name.lower()]

WeekDirs.sort()

if not WeekDirs: #If weekly directories were missing
	azz.write('Weekly directories missing, cannot continue with assessment!\n\n')
	azz.close()
	sys.exit('Continue was here')
else:
	azz.write('Found '+ str(len(WeekDirs)) +\
	' weekly directories: ' + ', '.join(WeekDirs) + '\n\n')
	azz.write('The '+ args.Week +' directory will be assessed \n\n')

####################################################
azz.write('='*70 + '\n')
azz.write('='*70 + '\n')
azz.write('PART 2: Checking weekly code and workflow...\n\n')

for week in WeekDirs:
	if not args.Week.lower() in week.lower().replace(" ", ""):
		continue # only assess for current week - no week 10 and 1, for eg
	azz.write('='*70 + '\n')
	WeekPth = RepoPath+'/'+week
	azz.write('Assessing ' + week.upper()+'...\n\n')
	DirCont = os.listdir(WeekPth)
	TempDirs = [name for name in DirCont if os.path.isdir(WeekPth +'/' + name)]
	TempFiles = [name for name in DirCont if os.path.isfile(WeekPth +'/' + name)]
	azz.write('Found the following directories: '\
	 + ', '.join(TempDirs) + '\n\n')
	azz.write('Found the following files: '\
	 + ', '.join(TempFiles) + '\n\n')

	azz.write('Checking for readme file in weekly directory...\n\n')
	readme = 'n'
	for name in TempFiles:
		if 'readme' in name.lower() and not '~' in name.lower():
			azz.write('Found README in parent directory, named: ' + name + '\n\n')
			azz.write('Printing contents of ' + name + ':' + '\n')
			g = open(WeekPth + '/' + name, 'r')
			azz.write('*'*70 + '\n')
			for line in g:
				azz.write(line,)
			g.close()
			azz.write('*'*70 + '\n\n')
			readme = 'y'
			break
	if readme == 'n':
		azz.write('README file missing, 1 pt deducted\n\n')
		Points = Points - 1
		azz.write('Current Points = ' + str(Points) + '\n\n')

	CodDir = [name for name in TempDirs if 'code' in name.lower()]
	DatDir = [name for name in TempDirs if 'data' in name.lower()]
	ResDir = [name for name in TempDirs if 'result' in name.lower()]
	if not CodDir:
		azz.write('Code directory missing!\n')
		azz.write('Aborting this weeks assessment!\n\n')
		break

	if not DatDir: azz.write('Data directory missing!\n\n')

	if not ResDir:
		azz.write('Results directory missing!\n\n')
		azz.write('Creating Results directory...\n\n')
		os.makedirs(WeekPth+'/Results')
	else:
		ResNames = []
		for root, dirs, files in os.walk(WeekPth + '/' + ResDir[0]):
			for file in files:
				ResNames.append(file)
		azz.write('Found following files in results directory: ' + ', '.join(ResNames) + '...\n\n')
		if len(ResNames)>1:
				azz.write('Ideally, Results directory should be empty other than, perhaps, a readme. \n\n')
		else:
			azz.write('\n')

	## Now get all code file paths for testing
	Scripts = []
	ScriptNames = []
	for root, dirs, files in os.walk(WeekPth + '/' + CodDir[0]):
		for file in files:
			if file.lower().endswith(('.sh','.py','.ipynb','.r','.txt','.bib','.tex')):
				 Scripts.append(os.path.join(root, file))
				 ScriptNames.append(file)

	azz.write('Found ' + str(len(Scripts)) + ' code files: ' + ', '.join(ScriptNames) + '\n\n')
	files = [fname for fname in files if fname not in ignore_files] # remove files to be ignored
	if len(ScriptNames) < len(files):
		extras = list(set(files) - set(ScriptNames))
		extras = [name for name in extras if not (name.lower().endswith(('~', 'pyc')))] #ignore certain extensions
		azz.write('Found the following extra files: ' + ', '.join(extras) + '\n')
		Points = Points - .5 * len(extras)
		azz.write('0.5 pt deducted per extra file\n\n')
		azz.write('Current Points = ' + str(Points) + '\n\n')

	## Now test all valid script files that were found
	azz.write('='*70 + '\n')
	azz.write('Testing script/code files...\n\n')

	errors = 0 #error counter
	for name in Scripts:
		## cd to current script's directory
		os.chdir(os.path.dirname(name))

		azz.write('='*70 + '\n')

		azz.write('Inspecting script file ' + os.path.basename(name) + '...\n\n')
		azz.write('File contents are:\n')
		azz.write('*'*70 + '\n')

		g = open(os.path.basename(name), 'r')
		for line in g:
			azz.write(line,)
		g.close()
		azz.write('*'*70 + '\n\n')

		azz.write('Testing ' + os.path.basename(name) + '...\n\n')
		print('Testing ' + os.path.basename(name) + '...\n\n')

		if os.path.basename(name).lower().endswith('.sh'):
			p, output, err, time = run_popen('bash ' + os.path.basename(name), timeout)
		elif os.path.basename(name).lower().endswith('.py'):
			azz.write(os.path.basename(name) + ' is a Python script file;\n\nchecking for docstrings...\n\n')
			with open(os.path.basename(name)) as f:
				funcs = re.findall(r'def\s.+:',f.read(),re.MULTILINE)
			with open(os.path.basename(name)) as f:
				dstrngs = re.findall(r'"""[\w\W]*?"""',f.read(),re.MULTILINE)

				if len(funcs)>0 and len(dstrngs)>0:
					azz.write('Found one or more docstrings and functions\n\n')
					if len(dstrngs) < len(funcs) + 1:
						azz.write('Missing docstring, either in one or functions and/or at the script level\n')
						Points = Points - (len(funcs) + 1 - len(dstrngs)) * 0.5
						azz.write('\n')
				elif len(funcs)>0 and len(dstrngs)==0:
					azz.write('Found one or more functions, but completely missing docstrings\n')
					Points = Points - 2 - len(funcs)*0.5
					azz.write('2 pts deducted for missing docstring for script, and .5 pt deducted per missing docstring for function\n\n')
				elif len(funcs)==0 and len(dstrngs)==1:
					azz.write('Found no functions, but one docstring for the script, good\n\n')
				elif len(funcs)==0 and len(dstrngs)>2:
					# import ipdb; ipdb.set_trace()
					azz.write('Found too many docstrings.  Check your script.\n\n')
				else:
					azz.write('No functions, but no script-level docstring either\n')
					Points = Points - 2
					azz.write('2 pts deducted\n\n')

			azz.write('Current Points = ' + str(Points) + '\n\n')

			p, output, err,	time = run_popen('python3 ' + os.path.basename(name), timeout)

		elif os.path.basename(name).lower().endswith('.r'):
			p, output, err,	time = run_popen('/usr/lib/R/bin/Rscript ' + os.path.basename(name), timeout)
		else:
			os.chdir(scrptPath)
			continue

		chars = 0

		azz.write('Output (only first ' + str(charLim) + ' characters): \n\n')
		azz.write('*'*70 + '\n')
		for char in output:
			print(char), # use end = '' to removes extra newline in python 3.xx
			subprocess.sys.stdout.flush()
			azz.write(char,)
			chars += 1
			if chars > charLim: # Limit the amount of output
				break

		azz.write('\n')
		azz.write('*'*70 + '\n')
		if not err:
			azz.write('\nCode ran without errors\n\n')
			azz.write('Time consumed = ' +"{:.5f}".format(time)+ 's\n\n')
		else:
			errors += 1
			azz.write('\nEncountered error (or warning):\n')
			azz.write(err)
			azz.write('\n')

		print('\nFinished with ' + os.path.basename(name)+  '\n\n')
		os.chdir(scrptPath)

	azz.write('='*70 + '\n')
	azz.write('='*70 + '\n')
	azz.write('Finished running scripts\n\n')
	azz.write('Ran into ' + str(errors)+' errors\n\n')

azz.write('='*70 + '\n')
azz.write('='*70 + '\n')
azz.write('\nFINISHED WEEKLY ASSESSMENT\n\n')
azz.write('Current Points for the Week = ' + str(Points) + '\n\n')
azz.write('NOTE THAT THESE ARE POINTS, NOT MARKS FOR THE WEEK!')

azz.close()

# Delete cloned repo
shutil.rmtree('CLONE_CMEE/')

# Open assessment file
subprocess.check_output(['open', azzFileName])

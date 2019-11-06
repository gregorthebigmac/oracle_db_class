# Git Instructions

This will go through some basic git (as well as git*hub*) instructions. This will be broken up into categories, based on where you are in the project.
\- Written and maintained by Kyle Gray

## You Don't Have a Github Account Yet

If you don't have a Github account yet, you **need** to make one before you can even *see* the repo, let alone download/modify it. Go to https://github.com and register for an account. It's free, and all you need is an email.

ProTip: I DON'T recommend using your EIU email for registering with github. Git (and by extension, git*hub*) is extremely useful, and I don't know if we'll have access to our student emails once we graduate, and you'll most likely want to *keep* your account once you're out of school, so I highly recommend using your personal email (or a spam email, if you keep one) to register for github.

## You Have an Account, but Not Access to the Repo

If you have created your github account, but you don't have access to the repo, just get on Slack and send me a DM with your github username (or email, if you prefer), and tell me you need access. I'll reply to your DM with a github repo "request access" link.

Click the link, and you will be granted access. At this point, you should have full permissions to the repo. You should be able to clone, pull, commit, and push to the repo (Instructions on those below).

## You Have Access to the Repo, But You Have No Idea What You're Doing

No worries. It's not as hard as it seems. I'm going to make sub-category directions for Win/Linux/Mac.

### Linux Instructions

#### Make sure git is installed

From the terminal, type

    $ git

If git is NOT installed, it will say so. If you're running Ubuntu, it will say something like:

    git is not installed. You can install it with 'apt-get install git'

If you're running some other distro, the message will be different.

I suggest creating a directory for ALL of your git repos in your home directory. This is pretty straightforward, so here's the command:

    $ cd ~
	$ mkdir git_repos
	$ cd git_repos
	$ git clone https://github.com/gregorthebigmac/oracle_db_class
	$ cd oracle_db_class

Done!
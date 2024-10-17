# How to clean commit history

1. Create a new orphan branch
Create a new orphan branch, which is a branch that has no commit history. We'll name it clean-history, but you can use any name you prefer:

**git checkout --orphan clean-history**
2. Stage all your files

**git add .**
3. Commit the changes
**git commit -m "Initial commit"**
4. Delete the old branch
Switch back to the main (or master) branch temporarily:
This command deletes the old branch along with its entire history.
**git branch -D main**
5. Rename the orphan branch to main
Rename the new orphan branch to main (or whatever your primary branch is called):
**git branch -m main**
6. Force-push the changes to the remote repository
Force-push your new branch to the remote repository to overwrite the existing history:
**git push -f origin main**

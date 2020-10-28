# Lowest Common Ancestor problem implemented in python 
  
# A node in our binary tree
class Node:
    def __init__(self, key=None):
        self.key = key
        self.left = None
        self.right = None

# Locates the path from the root node to the root that is given. 
# The path is stored in a list path[], if path exists, return true, otherwise false. 
def getPath(root, path, x):
    if root.key is None:
        return False

    path.append(root.key)
    if root.key == x:
        return True

    if ((root.left is not None and getPath(root.left, path, x)) or
            (root.right is not None and getPath(root.right, path, x))):
        return True

    path.pop()
    return False

# Returns LCA if node n1 , n2 are present in the given 
# binary tre otherwise return -1 
def findLCA(root, n1, n2):
    path1 = []
    path2 = []

    if not getPath(root, path1, n1) or not getPath(root, path2, n2):
        return -1

    i = 0
    while i < len(path1) and i < len(path2):
        if path1[i] != path2[i]:
            break
        i += 1
    return path1[i - 1]
from unittest import TestCase

from lca import *


class TestLCA(TestCase):
    # testing the function getPath. If we can find a path to the node it returns true, if not, false.

    # test when there are no elements in the tree
    def test_PathEmpty(self):
        root = Node()
        path = []
        self.assertEqual(getPath(root, path, 7), False)

    # find the path from the root back to itself
    def test_PathRoot(self):
        path = []
        root = Node(1)
        self.assertEqual(getPath(root, path, 1), True)

    # test on a non-empty tree with two different nodes
    def test_findPath(self):
        path = []
        root = Node(1)
        root.left = Node(2)
        root.right = Node(3)
        root.left.left = Node(4)
        root.left.right = Node(5)
        root.right.left = Node(6)
        root.right.right = Node(7)
        # visual representation of the tree
        #           (1)
        #         /     \
        #       (2)     (3)
        #       / \     / \
        #    (4)   (5)(6)   (7)
    
    # testing a complete tree
    def test_findLCA(self):
        root = Node(1)
        root.left = Node(2)
        root.right = Node(5)
        root.left.left = Node(3)
        root.left.left.right = Node(7)
        root.left.right = Node(4)
        root.right.right = Node(6)
        root.right.right.right = Node(8)

        # visual representation of the tree
        #          (1)
        #          / \
        #       (2)  (5)
        #       / \    \
        #     (3) (4)  (6)
        #        \       \
        #        (7)     (8)
        

        # testing two nodes that are on different sides of the tree
        self.assertEqual(findLCA(root, 7, 8), 1)

        # testing two nodes on different level of same side of tree
        self.assertEqual(findLCA(root, 7, 4), 2)

        # testing two different nodes, one of which is the LCA
        self.assertEqual(findLCA(root, 5, 6), 5)

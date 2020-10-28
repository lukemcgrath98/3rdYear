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


    # testing the findLCA function - if the LCA exists, return it, if not return -1
    # testing an empty tree
    def test_EmptyTree(self):
        root = Node()
        path = []
        self.assertEqual(findLCA(root, 3, 4), -1)

    def test_NotInTree(self):
        root = Node(1)
        self.assertEqual(findLCA(root, 2, 6), -1)

    # testing only root - (should return itself, as a node can be an ancestor of itself)
    def test_findLCARoot(self):
        root = Node(1)
        path = []
        self.assertEqual(findLCA(root, 1, 1), 1)

    # test for complete tree
    def test_findLCA(self):
        root = Node(1)
        root.left = Node(2)
        root.right = Node(6)
        root.left.left = Node(3)
        root.left.left.right = Node(4)
        root.left.left.right.right = Node(5)
        root.left.right = Node(9)
        root.right.right = Node(7)
        root.right.right.right = Node(8)

from unittest import TestCase

from dag import *


class TestDAG(TestCase):

    # testing isAcyclic, will return false if there is a cycle contained in the graph
    def test_isAcyclic_No(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_edge('a', 'b')
        dag.add_node('c')
        dag.add_edge('b', 'c')
        dag.add_edge('c', 'a')

        #        a
        #      /   \
        #     b  -  c

        self.assertFalse(wraps_acyclically(dag.graph))

    # testing a graph that contains no cycles
    def test_isAcyclic_Yes(self):
        dag = DAG()
        dag.add_node('b')
        dag.add_node('a')
        dag.add_node('c')
        dag.add_node('d')
        dag.add_edge('a', 'c')
        dag.add_edge('a', 'b')
        dag.add_edge('b', 'd')

        #       a
        #     /   \
        #    c     b
        #           \
        #            d

        self.assertTrue(wraps_acyclically(dag.graph))

    # testing an LCA that only has a single node
    def test_findLCA_OneNode(self):
        dag = DAG()
        dag.add_node('a')
        self.assertTrue(findLCA(dag.graph, 'a', 'b') == -1)

    # testing an LCA that is an empty graph
    def test_findLCA_Empty(self):
        dag = DAG()
        self.assertTrue(findLCA(dag.graph, 'a', 'b') == -1)

    # testing an LCA that has two nodes but no edge
    def test_findLCA_NoEdge(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        self.assertEqual(findLCA(dag.graph, 'a', 'b'), -1)

    # testing an LCA that has two nodes and an edge
    def test_findLCA_OneNotInGraph(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_edge('a', 'b')
        self.assertTrue(findLCA(dag.graph, 'a', 'g') == -1)


    # testing an LCA that has 2 nodes and one of them is the LCA
    def test_findLCA_OneNodeIsLCA(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_edge('a', 'b')
        self.assertEqual(findLCA(dag.graph, 'a', 'b'), 'a')

    # testing an LCA with a node either side of the root
    def test_findLCA_BothSides(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_node('c')
        dag.add_edge('a', 'b')
        dag.add_edge('a', 'c')

        #         a
        #        / \
        #       b   c

        self.assertEqual(findLCA(dag.graph, 'b', 'c'), 'a')

    # testing findLCA with a cyclic graph
    def test_findLCA_Cyclic(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_edge('a', 'b')
        dag.add_node('c')
        dag.add_edge('b', 'c')
        dag.add_edge('c', 'a')

        #        a
        #      /   \
        #     b  -  c

        self.assertEqual(findLCA(dag.graph, 'a', 'b'), -1)

    # testing a bigger graph
    def test_findLCA_BigGraph(self):
        dag = DAG()
        dag.add_node('a')
        dag.add_node('b')
        dag.add_node('c')
        dag.add_node('d')
        dag.add_node('e')
        dag.add_node('f')
        dag.add_node('g')
        dag.add_node('h')
        dag.add_node('i')


        dag.add_edge('a', 'b')
        dag.add_edge('a', 'c')
        dag.add_edge('b', 'd')
        dag.add_edge('b', 'e')
        dag.add_edge('b', 'f')
        dag.add_edge('c', 'g')
        dag.add_edge('c', 'h')
        dag.add_edge('c', 'i')

        #             a
        #            /  \
        #          /      \
        #         b        c
        #       / | \    / | \
        #      d  e  f  g  h  i

        self.assertEqual(findLCA(dag.graph, 'e', 'i'), 'a')
        self.assertEqual(findLCA(dag.graph, 'e', 'h'), 'a')
        self.assertEqual(findLCA(dag.graph, 'a', 'i'), 'a')
        self.assertEqual(findLCA(dag.graph, 'g', 'h'), 'c')
        self.assertEqual(findLCA(dag.graph, 'd', 'f'), 'b')

    # test for graph from lecture slides
    def test_findLCA_LectureGraph(self):
        dag = DAG()
        dag.add_node(1)
        dag.add_node(2)
        dag.add_node(3)
        dag.add_node(4)
        dag.add_node(5)
        dag.add_node(6)
        dag.add_node(7)
        dag.add_node(8)
        dag.add_node(9)
        dag.add_node(10)
        dag.add_node(11)
        dag.add_node(12)
        dag.add_node(13)

        dag.add_edge(1, 2)
        dag.add_edge(2, 4)
        dag.add_edge(4, 6)
        dag.add_edge(1, 3)
        dag.add_edge(3, 5)
        dag.add_edge(5, 8)
        dag.add_edge(5, 7)
        dag.add_edge(7, 10)
        dag.add_edge(10, 9)
        dag.add_edge(10, 13)
        dag.add_edge(10, 11)
        dag.add_edge(11, 12)

        #              1
        #             / \
        #            2   3
        #           /   /
        #          4   5
        #         /   / \
        #        6   7   8
        #            |
        #          / | \
        #         9  13  11
        #                  \
        #                   12

        self.assertEqual(findLCA(dag.graph, 8, 9), 5)
        self.assertEqual(findLCA(dag.graph, 11, 6), 1)
        self.assertEqual(findLCA(dag.graph, 3, 12), 3)

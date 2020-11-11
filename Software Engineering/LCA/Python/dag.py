import sys


class DAG:

    def __init__(self):
        self.make_graph()

    def make_graph(self):
        self.graph = {}

    def add_node(self, node, graph=None):
        if not graph:
            graph = self.graph

        if node in graph:
            return False

        graph[node] = []

    def add_edge(self, first_node, last_node, graph=None):
        if not graph:
            graph = self.graph

        if first_node in graph and last_node in graph:
            graph[first_node].append(last_node)
            return True
        else:
            raise KeyError("Nodes are invalid")


def wraps_acyclically(graph):
    result = True
    for node in graph:
        if not isAcyclic([node], graph, node):
            result = False
            break

    return result


def isAcyclic(node_list, graph, node):
    if not graph[node]:
        return True
    else:
        for child in graph[node]:
            if child not in node_list:
                node_list.append(child)
                if not isAcyclic(node_list, graph, child):
                    return False
                node_list.remove(child)
            else:
                return False
        return True

def findLCA(graph, nodeA, nodeB):
    if not wraps_acyclically(graph):
        return -1
    global node_A_list
    node_A_list = []
    global node_B_list
    node_B_list = []

    for node in graph:
        LCA_DFS([node], graph, node, 1, nodeA)
        LCA_DFS([node], graph, node, 2, nodeB)

    lowest_count = sys.maxsize
    for itemA in node_A_list:
        for itemB in node_B_list:
            count = 0 
            for index, node1 in enumerate(reversed(itemA)):
                count = index
                for node2 in reversed(itemB):
                    if node1 == node2 and count < lowest_count:
                        LCANode = node2
                        lowest_count = count
                        return LCANode

                    count += 1
    return -1

def LCA_DFS(node_list, graph, node, index, end_node):
    if node == end_node:

        if index == 1:
            node_A_list.append(node_list[:])
        elif index == 2:
            node_B_list.append(node_list[:])
        return True

    if not graph[node]:
        return True

    else:
        for child in graph[node]:
            node_list.append(child)  
            LCA_DFS(node_list, graph, child, index, end_node)
            node_list.remove(child)
        return True

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class testLCA {
	LCA tree = new LCA(); 
	
	@Before
	public void setUp(){
		tree.root = new Node(1); 
		tree.root.left = new Node(2); 
		tree.root.right = new Node(3); 
		tree.root.left.left = new Node(4); 
		tree.root.left.right = new Node(5); 
		tree.root.right.left = new Node(6); 
		tree.root.right.right = new Node(7); 
	}
//			Visual representation of Tree
//	                  (1)
//	                 /   \
//	              (2)     (3)
//	             /  \     /  \
//	           (4)  (5)  (6) (7)

	@Test 
	public void testDifferent() {           // Testing cases where two different existing nodes are used as input
		assertEquals(2, tree.findLCA(4,5));
		assertEquals(1, tree.findLCA(4,6));
	}
	
	public void testSame() {                  // Testing cases where the same node is used twice as input
		assertEquals(4, tree.findLCA(4,4));
		assertEquals(1, tree.findLCA(1,1));

	}
	public void testParent() {               // Testing cases where the result will be a node that is used in the input ( as it is the parent of itself )
		assertEquals(2, tree.findLCA(2,4));
		assertEquals(1, tree.findLCA(1,7));

	}
	public void testNonExistingNode() {      // Testing nodes that do not exist, we always expect -1 as a result when a non-existing node is used as input
		assertEquals(-1, tree.findLCA(1,9));
		assertEquals(-1, tree.findLCA(34,1));

	}
}


import tensorflow as tf
node1 = tf.constant(3.0, tf.float32)
node2 = tf.constant(4.0)
#print(node1, node2)
#for encapsulation the control and sate of tf runtime
sess = tf.Session()
print(sess.run([node1, node2]))

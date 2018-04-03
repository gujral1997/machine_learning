import tensorflow as tf
a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)

adder_node = a+b

sess = tf.Session()
print(sess.run(add, {a:[1,3]}))

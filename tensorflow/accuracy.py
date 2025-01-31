import tensorflow as tf

w = tf.Variable([.3], tf.float32)
b = tf.Variable([-.3], tf.float32)
x = tf.placeholder(tf.float32)
linear_model = w*x+b
init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init)
# print(sess.run(linear_model, {x:[1,2,3,4]}))

y = tf.placeholder(tf.float32)

squared_deltas = tf.square(linear_model - y)

loss = tf.reduce_sum(squared_deltas)

# print(sess.run(loss, {x:[1,2,3,4], y:[0,-1,-2,-3]}))

# here loss is 23.66 which is very poor so we have to optimize it

optimizer = tf.train.GradientDescentOptimizer(0.01)

train = optimizer.minimize(loss)

sess.run(init)

for i in range(1000):
    sess.run(train, {x:[1,2,3,4], y:[0, -1, -2, -3]})


print(sess.run([w, b]))

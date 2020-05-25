import tensorflow as tf


@tf.function
def f(x):
      return tf.square(x)

print(f(tf.constant(1, dtype=tf.int32)))
print(f(tf.constant(1.0, dtype=tf.float32)))


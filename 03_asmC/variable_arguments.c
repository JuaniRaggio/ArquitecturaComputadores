// This usage of variable arguments is really cool

// Example code

struct TransformParameters {
  Vec2 pivot; // Default TopLeft
  Dim2 scale; // Default No Scale
  f32  angle;  // Default 0 (No angle)
  b32  clip;   // Default False
};

int main(void) {
  PushTransform(rect);                                  // Use all defaults
  PushTransform(rect, .scale = Vec2Half);               // Override defaukt scale
  PushTransform(rect, .angle = 90.0f, .pivot = Center); // Override Angle & pivot

  struct TransformParameters params = {
    .pivot = TopLeft,
    .scale = Vec2One,
    .angle = 0,
    .clip = false,
  };
  _PushTransform(rect, params); // Pass arguments as a struct
}

#define PushTransform(rect, ...) \
  _PushTransform((rect), (TransformParameters) {.scale = Vec2One, __VA_ARGS__})
void *_PushTransform(Rect rect, TransformParameters params) { /* Implementation */ }


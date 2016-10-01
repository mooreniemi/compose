/*
 * =====================================================================================
 *
 *       Filename:  Compose.c
 *
 *    Description:  Proc composition
 *
 *        Version:  1.0
 *        Created:  10/01/2016 16:14:22
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Alex Moore-Niemi
 *
 * =====================================================================================
 */

#include "ruby.h"

// Defining a space for information and references about the module to be stored internally
VALUE Compose = Qnil;

// Prototype for the initialization method - Ruby calls this, not you
void Init_compose();

VALUE method_compose(VALUE self, VALUE args) {
  VALUE result = rb_ary_new2(1);

  FILE *f = fopen("clog.txt", "w");
  if (f == NULL) {
    printf("no log file found\n");
    exit(1);
  }
  //fprintf(f, "array: %s\n", RSTRING_PTR(rb_ary_to_s(self)));

  return result;
}

// The initialization method for this module
void Init_compose() {
  rb_define_method(rb_cProc, "compose", method_compose, -2);
}

# Copyright, 2010-2012 by Jari Bakken.
# Copyright, 2013, by Samuel G. D. Williams. <http://www.codeotaku.com>
# Copyright, 2013, by Garry C. Marshall. <http://www.meaningfulname.net>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'ffi/clang/lib/translation_unit'
require 'ffi/clang/lib/diagnostic'
require 'ffi/clang/lib/comment'
require 'ffi/clang/lib/type'
require 'ffi/clang/utils'

module FFI
	module Clang
		module Lib
			enum :kind, [
				:cursor_unexposed_decl, 1,
				:cursor_struct, 2,
				:cursor_union, 3,
				:cursor_class_decl, 4,
				:cursor_enum_decl, 5,
				:cursor_field_decl, 6,
				:cursor_enum_constant_decl, 7,
				:cursor_function, 8,
				:cursor_variable, 9,
				:cursor_parm_decl, 10,
				:cursor_obj_c_interface_decl, 11,
				:cursor_obj_c_category_decl, 12,
				:cursor_obj_c_protocol_decl, 13,
				:cursor_obj_c_property_decl, 14,
				:cursor_obj_c_instance_var_decl, 15,
				:cursor_obj_c_instance_method_decl, 16,
				:cursor_obj_c_class_method_decl, 17,
				:cursor_obj_c_implementation_decl, 18,
				:cursor_obj_c_category_impl_decl, 19,
				:cursor_typedef_decl, 20,
				:cursor_cxx_method, 21,
				:cursor_namespace, 22,
				:cursor_linkage_spec, 23,
				:cursor_constructor, 24,
				:cursor_destructor, 25,
				:cursor_conversion_function, 26,
				:cursor_template_type_parameter, 27,
				:cursor_non_type_template_parameter, 28,
				:cursor_template_template_parameter, 29,
				:cursor_function_template, 30,
				:cursor_class_template, 31,
				:cursor_class_template_partial_specialization, 32,
				:cursor_namespace_alias, 33,
				:cursor_using_directive, 34,
				:cursor_using_declaration, 35,
				:cursor_type_alias_decl, 36,
				:cursor_obj_c_synthesize_decl, 37,
				:cursor_obj_c_dynamic_decl, 38,
				:cursor_cxx_access_specifier, 39,
				:cursor_obj_c_super_class_ref, 40,
				:cursor_obj_c_protocol_ref, 41,
				:cursor_obj_c_class_ref, 42,
				:cursor_type_ref, 43,
				:cursor_cxx_base_specifier, 44,
				:cursor_template_ref, 45,
				:cursor_namespace_ref, 46,
				:cursor_member_ref, 47,
				:cursor_label_ref, 48,
				:cursor_overloaded_decl_ref, 49,
				:cursor_variable_ref, 50,
				:cursor_invalid_file, 70,
				:cursor_no_decl_found, 71,
				:cursor_not_implemented, 72,
				:cursor_invalid_code, 73,
				:cursor_first_expr, 100,
				:cursor_decl_ref_expr, 101,
				:cursor_member_ref_expr, 102,
				:cursor_call_expr, 103,
				:cursor_obj_c_message_expr, 104,
				:cursor_block_expr, 105,
				:cursor_integer_literal, 106,
				:cursor_floating_literal, 107,
				:cursor_imaginary_literal, 108,
				:cursor_string_literal, 109,
				:cursor_character_literal, 110,
				:cursor_paren_expr, 111,
				:cursor_unary_operator, 112,
				:cursor_array_subscript_expr, 113,
				:cursor_binary_operator, 114,
				:cursor_compound_assign_operator, 115,
				:cursor_conditional_operator, 116,
				:cursor_c_style_cast_expr, 117,
				:cursor_compound_literal_expr, 118,
				:cursor_init_list_expr, 119,
				:cursor_addr_label_expr, 120,
				:cursor_stmt_expr, 121,
				:cursor_generic_selection_expr, 122,
				:cursor_gnu_null_expr, 123,
				:cursor_cxx_static_cast_expr, 124,
				:cursor_cxx_dynamic_cast_expr, 125,
				:cursor_cxx_reinterpret_cast_expr, 126,
				:cursor_cxx_const_cast_expr, 127,
				:cursor_cxx_functional_cast_expr, 128,
				:cursor_cxx_typeid_expr, 129,
				:cursor_cxx_bool_literal_expr, 130,
				:cursor_cxx_null_ptr_literal_expr, 131,
				:cursor_cxx_this_expr, 132,
				:cursor_cxx_throw_expr, 133,
				:cursor_cxx_new_expr, 134,
				:cursor_cxx_delete_expr, 135,
				:cursor_unary_expr, 136,
				:cursor_obj_c_string_literal, 137,
				:cursor_obj_c_encode_expr, 138,
				:cursor_obj_c_selector_expr, 139,
				:cursor_obj_c_protocol_expr, 140,
				:cursor_obj_c_bridged_cast_expr, 141,
				:cursor_pack_expansion_expr, 142,
				:cursor_size_of_pack_expr, 143,
				:cursor_lambda_expr, 144,
				:cursor_obj_c_bool_literal_expr, 145,
				:cursor_obj_c_self_expr, 146,
				:cursor_unexposed_stmt, 200,
				:cursor_label_stmt, 201,
				:cursor_compound_stmt, 202,
				:cursor_case_stmt, 203,
				:cursor_default_stmt, 204,
				:cursor_if_stmt, 205,
				:cursor_switch_stmt, 206,
				:cursor_while_stmt, 207,
				:cursor_do_stmt, 208,
				:cursor_for_stmt, 209,
				:cursor_goto_stmt, 210,
				:cursor_indirect_goto_stmt, 211,
				:cursor_continue_stmt, 212,
				:cursor_break_stmt, 213,
				:cursor_return_stmt, 214,
				:cursor_gcc_asm_stmt, 215,
				:cursor_obj_c_at_try_stmt, 216,
				:cursor_obj_c_at_catch_stmt, 217,
				:cursor_obj_c_at_finally_stmt, 218,
				:cursor_obj_c_at_throw_stmt, 219,
				:cursor_obj_c_at_synchronized_stmt, 220,
				:cursor_obj_c_autorelease_pool_stmt, 221,
				:cursor_obj_c_for_collection_stmt, 222,
				:cursor_cxx_catch_stmt, 223,
				:cursor_cxx_try_stmt, 224,
				:cursor_cxx_for_range_stmt, 225,
				:cursor_seh_try_stmt, 226,
				:cursor_seh_except_stmt, 227,
				:cursor_seh_finally_stmt, 228,
				:cursor_ms_asm_stmt, 229,
				:cursor_null_stmt, 230,
				:cursor_decl_stmt, 231,
				:cursor_omp_parallel_directive, 232,
				:cursor_translation_unit, 300,
				:cursor_unexposed_attr, 400,
				:cursor_ibaction_attr, 401,
				:cursor_iboutlet_attr, 402,
				:cursor_iboutlet_collection_attr, 403,
				:cursor_cxx_final_attr, 404,
				:cursor_cxx_override_attr, 405,
				:cursor_annotate_attr, 406,
				:cursor_asm_label_attr, 407,
				:cursor_packed_attr, 408,
				:cursor_preprocessing_directive, 500,
				:cursor_macro_definition, 501,
				:cursor_macro_expansion, 502,
				:cursor_inclusion_directive, 503,
				:cursor_module_import_decl, 600,
			]

			enum :access_specifier, [
				:invalid, 0,
				:public, 1,
				:protected, 2,
				:private, 3
			]

			enum :availability, [
				:available, 0,
				:deprecated, 1,
				:not_available, 2,
				:not_accesible, 3
			]

			class CXCursor < FFI::Struct
				layout(
					:kind, :kind,
					:xdata, :int,
					:data, [:pointer, 3]
				)
			end

			enum :cxx_access_specifier, [:invalid, :public, :protected, :private]
			attach_function :get_cxx_access_specifier, :clang_getCXXAccessSpecifier, [CXCursor.by_value], :cxx_access_specifier

			attach_function :get_enum_value, :clang_getEnumConstantDeclValue, [CXCursor.by_value], :long_long

			attach_function :is_virtual_base, :clang_isVirtualBase, [CXCursor.by_value], :uint
			attach_function :is_dynamic_call, :clang_Cursor_isDynamicCall, [CXCursor.by_value], :uint
			attach_function :cxx_method_is_static, :clang_CXXMethod_isStatic, [CXCursor.by_value], :uint
			attach_function :cxx_method_is_virtual, :clang_CXXMethod_isVirtual, [CXCursor.by_value], :uint
			attach_function :is_variadic, :clang_Cursor_isVariadic, [CXCursor.by_value], :uint

			if FFI::Clang::Utils::clang_major_version >= 3 && FFI::Clang::Utils::clang_minor_version >= 4
				attach_function :cxx_method_is_pure_virtual, :clang_CXXMethod_isPureVirtual, [CXCursor.by_value], :uint
			end
			attach_function :cxx_get_access_specifier, :clang_getCXXAccessSpecifier, [CXCursor.by_value], :access_specifier
			
			enum :language_kind, [:invalid, :c, :obj_c, :c_plus_plus]
			attach_function :get_language, :clang_getCursorLanguage, [CXCursor.by_value], :language_kind

			attach_function :get_canonical_cursor, :clang_getCanonicalCursor, [CXCursor.by_value], CXCursor.by_value
			attach_function :get_cursor_definition, :clang_getCursorDefinition, [CXCursor.by_value], CXCursor.by_value
			attach_function :get_specialized_cursor_template, :clang_getSpecializedCursorTemplate, [CXCursor.by_value], CXCursor.by_value
			attach_function :get_template_cursor_kind, :clang_getTemplateCursorKind, [CXCursor.by_value], :kind

			attach_function :get_translation_unit_cursor, :clang_getTranslationUnitCursor, [:CXTranslationUnit], CXCursor.by_value

			attach_function :get_null_cursor, :clang_getNullCursor, [], CXCursor.by_value

			attach_function :cursor_is_null, :clang_Cursor_isNull, [CXCursor.by_value], :int

			attach_function :cursor_get_raw_comment_text, :clang_Cursor_getRawCommentText, [CXCursor.by_value], CXString.by_value
			attach_function :cursor_get_parsed_comment, :clang_Cursor_getParsedComment, [CXCursor.by_value], CXComment.by_value

			attach_function :get_cursor, :clang_getCursor, [:CXTranslationUnit, CXSourceLocation.by_value], CXCursor.by_value
			attach_function :get_cursor_location, :clang_getCursorLocation, [CXCursor.by_value], CXSourceLocation.by_value
			attach_function :get_cursor_extent, :clang_getCursorExtent, [CXCursor.by_value], CXSourceRange.by_value
			attach_function :get_cursor_display_name, :clang_getCursorDisplayName, [CXCursor.by_value], CXString.by_value
			attach_function :get_cursor_spelling, :clang_getCursorSpelling, [CXCursor.by_value], CXString.by_value
			attach_function :get_cursor_usr, :clang_getCursorUSR, [CXCursor.by_value], CXString.by_value

			attach_function :are_equal, :clang_equalCursors, [CXCursor.by_value, CXCursor.by_value], :uint

			attach_function :is_declaration, :clang_isDeclaration, [:kind], :uint
			attach_function :is_reference, :clang_isReference, [:kind], :uint
			attach_function :is_expression, :clang_isExpression, [:kind], :uint
			attach_function :is_statement, :clang_isStatement, [:kind], :uint
			attach_function :is_attribute, :clang_isAttribute, [:kind], :uint
			attach_function :is_invalid, :clang_isInvalid, [:kind], :uint
			attach_function :is_translation_unit, :clang_isTranslationUnit, [:kind], :uint
			attach_function :is_preprocessing, :clang_isPreprocessing, [:kind], :uint
			attach_function :is_unexposed, :clang_isUnexposed, [:kind], :uint

			attach_function :is_definition, :clang_isCursorDefinition, [CXCursor.by_value], :uint

			enum :child_visit_result, [:break, :continue, :recurse]

			callback :visit_children_function, [CXCursor.by_value, CXCursor.by_value, :pointer], :child_visit_result
			attach_function :visit_children, :clang_visitChildren, [CXCursor.by_value, :visit_children_function, :pointer], :uint

			attach_function :get_cursor_type, :clang_getCursorType, [CXCursor.by_value], CXType.by_value
			attach_function :get_cursor_result_type, :clang_getCursorResultType, [CXCursor.by_value], CXType.by_value
			attach_function :get_cursor_reference, :clang_getCursorReferenced, [CXCursor.by_value], CXCursor.by_value
			attach_function :get_cursor_semantic_parent, :clang_getCursorSemanticParent, [CXCursor.by_value], CXCursor.by_value
			attach_function :get_cursor_lexical_parent, :clang_getCursorLexicalParent, [CXCursor.by_value], CXCursor.by_value

			attach_function :get_cursor_hash, :clang_hashCursor, [CXCursor.by_value], :uint
		end
	end
end

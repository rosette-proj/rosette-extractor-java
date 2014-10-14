# encoding: UTF-8

require 'rosette/core'
require File.expand_path('../../../../vendor/JavaParser', __FILE__)

java_import 'org.antlr.v4.runtime.ANTLRInputStream'
java_import 'org.antlr.v4.runtime.CharStream'
java_import 'org.antlr.v4.runtime.CommonTokenStream'

java_import 'com.camertron.JavaParser.Java8Lexer'
java_import 'com.camertron.JavaParser.Java8Parser'
java_import 'com.camertron.JavaParser.FunctionCallVisitor'

module Rosette
  module Extractors

    class JavaExtractor < Rosette::Core::Extractor
      protected

      def each_function_call(java_code)
        if block_given?
          root = parse_java(java_code)

          visitor = FunctionCallVisitor.new(
            lambda { |node| yield node }.to_java(
              FunctionCallVisitor::FunctionCallNotifier
            )
          )

          visitor.visit(root)
        else
          to_enum(__method__, java_code)
        end
      end

      def valid_args?(fn_call)
        if fn_call.getArgumentList.children.size >= 1
          if literal = find_literal(fn_call.getArgumentList)
            text = literal.getText
            text[0] == '"' && text[-1] == '"'
          else
            false
          end
        else
          false
        end
      end

      def get_key(fn_call)
        find_literal(fn_call.getArgumentList).getText[1..-2]
      end

      private

      def find_literal(node)
        while node.children.size > 0
          break node if node.is_a?(Java8Parser::LiteralContext)
          node = node.children.first
        end
      end

      def parse_java(java_code)
        stream = ANTLRInputStream.new(java_code)
        lexer = Java8Lexer.new(stream)
        tokens = CommonTokenStream.new(lexer)
        parser = Java8Parser.new(tokens)
        parser.compilationUnit
      end

      class I18nExtractor < JavaExtractor
        protected

        def valid_name?(fn_call)
          fn_call.getTypeName &&
            fn_call.getTypeName.getText == 'I18n' &&
            fn_call.getName == 't'
        end
      end
    end

  end
end

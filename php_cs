<?php

$finder = PhpCsFixer\Finder::create()
    ->notPath('bootstrap/cache')
    ->notPath('storage')
    ->notPath('vendor')
    ->in(__DIR__)
    ->name('*.php')
    ->notName('*.blade.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return PhpCsFixer\Config::create()
    ->setRules([
        // PhpCsFixer is more opinionated, but nice.
        '@PhpCsFixer' => true,

        // PhpCsFixer rule set has these by default, although nice, it'll just create a lot of extra noise in the mean time.
        'php_unit_internal_class'                => false,
        'php_unit_test_class_requires_covers'    => false,
        'php_unit_method_casing'                 => false,

        'multiline_whitespace_before_semicolons' => ['strategy' => 'no_multi_line'],
        'yoda_style'                             => false,
        'phpdoc_types_order'                     => [
            'null_adjustment' => 'always_last',
            'sort_algorithm'  => 'none',
        ],
        'phpdoc_to_comment'      => false,
        'binary_operator_spaces' => [
            'align_double_arrow' => true,
        ],

        // PSR-12 provisional ruleset from https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/4502#issuecomment-570408101
        // March 5th 2020 version:
        '@PSR2'                             => true,
        'blank_line_after_opening_tag'      => true,
        'braces'                            => ['allow_single_line_closure' => true],
        'compact_nullable_typehint'         => true,
        'concat_space'                      => ['spacing' => 'one'],
        'declare_equal_normalize'           => ['space' => 'none'],
        'function_typehint_space'           => true,
        'new_with_braces'                   => true,
        'method_argument_space'             => ['on_multiline' => 'ensure_fully_multiline'],
        'no_empty_statement'                => true,
        'no_leading_import_slash'           => true,
        'no_leading_namespace_whitespace'   => true,
        'no_whitespace_in_blank_line'       => true,
        'return_type_declaration'           => ['space_before' => 'none'],
        'single_trait_insert_per_statement' => true,
        // End of PSR-12
    ])
    ->setFinder($finder);

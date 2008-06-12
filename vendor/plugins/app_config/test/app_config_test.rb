
require File.dirname(__FILE__) + '/ordered_options'
require File.dirname(__FILE__) + '/../lib/app_config'
require 'test/unit'

#require '../lib/app_config'
class AppConfigTest < Test::Unit::TestCase

    def test_accessor_methods
        AppConfig::Base.mail_from_address = 'sender@address.com'
        assert_equal( 'sender@address.com', AppConfig.mail_from_address)
        assert_nil AppConfig.mail_from_address_WRONG

        hash = {:k1=>Time.now, :k2=>'12312'}
        AppConfig::Base.hash_option = hash
        assert hash===AppConfig.hash_option
        assert_nil AppConfig.hash_optio_WRONG

        # not allowed methods:
        # (.*)= e.g. AppConfig.name=123,
        assert_raise(NoMethodError){ AppConfig.hash_option= 123 }
        assert_raise(NoMethodError){ AppConfig[:mail_from_address]= 123 }

        # (.*) with parameters e.g. AppConfig.name(1,2,3)
        assert_raise(NoMethodError){ AppConfig.mail_from_address(1) }
        assert_raise(NoMethodError){ AppConfig.mail_from_address(1,2) }
    end

    def test_hashlike_access
        AppConfig::Base.mail_from_address = 'sender@address.com'
        assert_equal( 'sender@address.com', AppConfig[:mail_from_address])
        assert_equal( 'sender@address.com', AppConfig['mail_from_address'])

        hash = {:k1=>Time.now, :k2=>'12312'}
        AppConfig::Base.hash_option = hash
        assert hash===AppConfig[:hash_option]
        assert hash===AppConfig['hash_option']
    end

    def test_param_with_default_access
        AppConfig::Base.mail_from_address = 'sender@address.com'
        assert_equal( 'sender@address.com', AppConfig.param(:mail_from_address))
        assert_equal( 'sender@address.com', AppConfig.param('mail_from_address'))

        # access to no existing parameter
        # without default val
        assert_nil(AppConfig.param(:NOmail_from_address))
        assert_nil(AppConfig.param('NOmail_from_address'))

        # with default value
        assert_equal( 'default@address.com', AppConfig.param(:NOmail_from_address, 'default@address.com'))
        assert_equal( 'default@address.com', AppConfig.param('NOmail_from_address', 'default@address.com'))
    end

    def test_param_with_block
        AppConfig::Base.mail_from_address = 'sender@address.com'
        assert_equal( 'sender@address.com', AppConfig.param(:mail_from_address){false})
        assert_equal( 'sender@address.com', AppConfig.param(:mail_from_address){false})

        # access to no existing parameter
        assert(AppConfig.param(:NOmail_from_address){true})
        assert(AppConfig.param('NOmail_from_address'){true})

        # enter either default or block, or...
        assert_raise ArgumentError do
             AppConfig.param(:foobar, 'default'){ true }
        end
    end

    def test_param_existing_check
        AppConfig::Base.mail_from_address = 'sender@address.com'
        assert AppConfig.has_param?(:mail_from_address)
        assert AppConfig.has_param?('mail_from_address')

        # parameter with nil value
        AppConfig::Base.nil_param = nil
        assert AppConfig.has_param?(:nil_param)
        assert AppConfig.has_param?('nil_param')

        # no existing parameter
        assert_equal false, AppConfig.has_param?(:no_exists)
        assert_equal false, AppConfig.has_param?('no_exists')
    end

    def test_boolean_params
        AppConfig::Base.some_param = false

        assert_equal false, AppConfig['some_param']
        assert_equal false, AppConfig.param('some_param')
        assert_equal false, AppConfig.param('some_param', true )
    end

end

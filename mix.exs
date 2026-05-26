defmodule Stripe.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ineedthis/stripity-stripe"
  @version "3.2.0"

  def project do
    [
      app: :stripity_stripe,
      version: @version,
      elixir: "~> 1.14",
      deps: deps(),
      docs: docs(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_add_apps: [:mix],
        plt_file: {:no_warn, "priv/plts/stripity_stripe.plt"}
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      extra_applications: [],
      env: env(),
      mod: {Stripe, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp env do
    [
      api_base_url: "https://api.stripe.com",
      api_upload_url: "https://files.stripe.com",
      pool_options: [
        timeout: 5_000,
        max_connections: 10
      ],
      use_connection_pool: true
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.25 or ~> 4.0"},
      {:jason, "~> 1.4"},
      {:telemetry, "~> 1.4"},
      {:uri_query, "~> 0.2.0"},
      {:plug, "~> 1.19", optional: true},
      # Non-production dependencies
      {:inch_ex, "~> 2.1", only: [:dev, :test]},
      {:mox, "~> 1.2", only: :test},
      {:erlexec, "~> 2.2.2", only: :test},
      {:dialyxir, "~> 1.4.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"],
      groups_for_modules: groups_for_modules(),
      nest_modules_by_prefix: nest_modules_by_prefix()
    ]
  end

  defp package do
    [
      description:
        "A Stripe client for Elixir. Fork with enhanced code generation and latest API spec.",
      files: ["lib", "LICENSE*", "mix.exs", "README*", "CHANGELOG*", "priv/openapi"],
      licenses: ["BSD-3-Clause"],
      maintainers: [
        "ineedthis (fork maintainer)",
        "Maarten van Vliet (original)",
        "Nikola Begedin (original)",
        "Scott Newcomer (original)"
      ],
      links: %{
        "GitHub" => @source_url,
        "Upstream" => "https://github.com/beam-community/stripity-stripe"
      }
    ]
  end

  defp groups_for_modules do
    [
      Main: [
        Stripe,
        Stripe.API,
        Stripe.ApiErrors,
        Stripe.Entity,
        Stripe.List,
        Stripe.Request,
        Stripe.SearchResult
      ],
      "Core Resources": [
        Stripe.Balance,
        Stripe.BalanceTransaction,
        Stripe.Charge,
        Stripe.Customer,
        Stripe.Dispute,
        Stripe.Event,
        Stripe.FileUpload,
        Stripe.FileLink,
        Stripe.Mandate,
        Stripe.PaymentIntent,
        Stripe.Payout,
        Stripe.Price,
        Stripe.Product,
        Stripe.Refund,
        Stripe.SetupIntent,
        Stripe.TaxId,
        Stripe.Token
      ],
      "Payment Methods": [
        Stripe.BankAccount,
        Stripe.Card,
        Stripe.PaymentMethod,
        Stripe.Source
      ],
      Checkout: [
        Stripe.Checkout.Session
      ],
      Billing: [
        Stripe.Coupon,
        Stripe.CreditNote,
        Stripe.CreditNoteLineItem,
        Stripe.CustomerTransactionBalance,
        Stripe.Discount,
        Stripe.Invoice,
        Stripe.Invoiceitem,
        Stripe.LineItem,
        Stripe.Product,
        Stripe.Plan,
        Stripe.Subscription,
        Stripe.SubscriptionItem,
        Stripe.UsageRecord,
        Stripe.SubscriptionSchedule,
        Stripe.TaxRate
      ],
      "Billing Portal": [
        Stripe.BillingPortal.Session
      ],
      Connect: [
        Stripe.Account,
        Stripe.ApplicationFee,
        Stripe.Capability,
        Stripe.Connect.OAuth,
        Stripe.Connect.OAuth.AuthorizeResponse,
        Stripe.Connect.OAuth.DeauthorizeResponse,
        Stripe.Connect.OAuth.TokenResponse,
        Stripe.CountrySpec,
        Stripe.ExternalAccount,
        Stripe.FeeRefund,
        Stripe.LoginLink,
        Stripe.Recipient,
        Stripe.Topup,
        Stripe.Transfer,
        Stripe.TransferReversal
      ],
      Fraud: [
        Stripe.Radar.EarlyFraudWarning,
        Stripe.Review
      ],
      Identity: [
        Stripe.Identity.VerificationSession,
        Stripe.Identity.VerificationReport
      ],
      Issuing: [
        Stripe.Issuing.Authorization,
        Stripe.Issuing.Card,
        Stripe.Issuing.Cardholder,
        Stripe.Issuing.Transaction,
        Stripe.Issuing.Types
      ],
      Terminal: [
        Stripe.Terminal.ConnectionToken,
        Stripe.Terminal.Location,
        Stripe.Terminal.Reader
      ],
      Utilities: [
        Stripe.Config,
        Stripe.Converter,
        Stripe.Types
      ],
      Other: [
        ~r/.*/
      ]
    ]
  end

  def nest_modules_by_prefix() do
    [
      Stripe.Connect.OAuth,
      Stripe.Connect.OAuth.AuthorizeResponse,
      Stripe.Connect.OAuth.TokenResponse,
      Stripe.Connect.OAuth.DeauthorizeResponse
    ]
  end
end
